% PCLOUD_NORMAL_ESTIMATE Estimates normals of point cloud
%
% SYNTAX
% [output] = pcloud_normal_estimate(P, kdtree, TYPE, K)
% 
% SYNTAX EXAMPLES
% P.normals = pcloud_normal_estimate(P, kdtree, 'hoppe', K)
% P.normals = pcloud_normal_estimate(P, [], 'hoppe', K)
% 
% INPUT PARAMETERS
%   P: a point cloud in "pcloud" format
%       - P.points: a "Nx3" matrix containing N points, one for each row
%   TYPE: the type of normal estimate that you want to use (default: 'hoppe')
%   K: the amount of nearest neighbor samples for the point cloud estimate (default: 5)
%
% OUTPUT PARAMETERS
%   normals: a Nx3 matrix containing the normals for the N points
%            entries are [NaN, NaN, NaN] whether normal was not 
%            processable for that point. (never happens?)
%
% DESCRIPTION
% Exhaustive and long description of functionality of pcloud_normal_estimate.
% 
% TYPE = 'hoppe'
% compute normals and re-orient them according to the algorithm suggested in [1].
% A reimannian graph is built over which a minimal spanning tree algorithm is executed.
% One of the points on the bounding box of the shape (with max z coordinate in this code)
% is picked to be the root of the tree. The tree structure is then explored trying to ensure
% continuity between normal direction of a point and its predecessor.
% 
% TYPE = 'pcurv': compute estimated principal curvatures
% Compute estimates of curvature frames. Normals are unoriented
%
% TYPE = 'pca'
% Compute estimates of normals where only direction is reliable.
% Orientation is not, for a reoriented solution consider TYPE='hoppe'
%
% See also:
% pcloud_normal_estimate_demo1.m 
% pcloud_normal_estimate_demo2.m
% pcloud_normal_estimate_demo3.m
% pcloud_normal_estimate_demo4.m
%
% References:
% [1] H.Hoppe, T.DeRose, T.Duchamp, J.McDonald, and W.Stuetzle. 
%     Surface reconstruction from unorganized points. SIGGRAPH, 1992.

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  23 sep. 2008: created, only PCA undirected normals
% $Revision: 1.1$  3  dec. 2008: implemented full Hoppe's algorithm
% $Revision: 1.0$  6  jan. 2008: added more complete comments
function [varargout] = pcloud_normal_estimate( varargin )

% PARSE INPUT
P       = defaultvalue( varargin, 1, [] );
kdtree  = defaultvalue( varargin, 2, [] );
TYPE    = defaultvalue( varargin, 3, 'hoppe');
k       = defaultvalue( varargin, 4, 5 );
p       = P.points;

if strcmp( TYPE, 'hoppe' )
    normals = zeros( size(P.points,1),3 );
    minCdir = zeros( size(P.points,1),3 );
    maxCdir = zeros( size(P.points,1),3 );
    kdtree = kdtree_build(p);
    k = 20;
 
    
    %%% Use PCA to estimate a normal direction
    h = txtwaitbar('init', 'Computin local PCA: ');
    for pIdx = 1:length(p)
        h = txtwaitbar(pIdx/length(p), h);
        idxs = kdtree_k_nearest_neighbors( kdtree, p(pIdx,:)', k);
        % compute cumulative outer products 
        CV = zeros(3,3); % (kroneker tensor products)
        for iIdx=1:size(idxs)
            vect = p(idxs(iIdx),:)-p(pIdx,:);
            CV = CV + kron(vect, vect');   
            [VEC,IGNORE] = svd( CV ); %#ok<NASGU>
            normals( pIdx, : ) = VEC(:,3)';
            minCdir( pIdx, : ) = VEC(:,2)';
            maxCdir( pIdx, : ) = VEC(:,1)';
        end  
    end
    txtwaitbar('close',h);

    %%% compute reimannian graph and its weights
    ADJ = sparse( length(p), length(p) );
    h = txtwaitbar('init', 'Reimannian Graph: ');
    for pIdx = 1:length(p)
        h = txtwaitbar(pIdx/length(p), h);
        idxs = kdtree_k_nearest_neighbors( kdtree, p(pIdx,:)', k);
        metric = zeros( length(idxs), 1 );
        for i=1:length(idxs)
           % myedge( P.points(pIdx,:), P.points(idxs(i),:), 'parent', hg );      
           metric(i) = 1-abs(normals(pIdx,:)*normals(idxs(i),:)');
        end
        ADJ( pIdx, idxs ) = metric;
        ADJ( idxs, pIdx ) = metric;
        ADJ( pIdx,pIdx   ) = 0;
    end
    txtwaitbar('close',h);
    
    %%% Find the point with largest z coordinate and correct its normal
    [IGN, maxidx] = max( p(:,2) );
    normals(maxidx,:) = sign(normals(maxidx,2))*normals(maxidx,:);
    
    %%% Construct an MSP of the Reimannian Graph
    TREE = graphminspantree( tril(ADJ), maxidx );
    [disc, pred] = graphtraverse(TREE, maxidx, 'Method', 'BFS', 'Directed', false);
    
    %%% Traverse the graph and correct normal orientations according
    %   to the predecessor
    h = txtwaitbar('init', 'Correcting Normals: ');
    for i=1:length(disc)
        h = txtwaitbar(pIdx/length(p), h);
        if pred(disc(i))==0, continue, end;

        % debug
        % mypoint(P.points(disc(i),:), '.r', 'parent', hg);

        currN = normals(disc(i),:);
        predN = normals(pred(disc(i)),:);
        if currN*predN' < 0
            normals(disc(i),:) = -currN;
        end
    end
    txtwaitbar('close',h);
    
    %%% Save normals in the output          
    varargout{1} = normals;
    if nargout >2
        varargout{2} = minCdir;
        varargout{3} = maxCdir;
    end
elseif strcmp( TYPE, 'pca' )
    normals = zeros( size(P.points,1),3 );
    kdtree = kdtree_build(p);
    h = txtwaitbar('init', 'computing normals: ');
    % for every point retrieve the kNN neighborhood, 
    % compute the sum of tensors and analyzes its 
    % eigenvalues to estimate the normal
    for pIdx = 1:size(p,1)
        idxs = kdtree_k_nearest_neighbors( kdtree, p(pIdx,:)', k);
        % compute cumulative outer products 
        CV = zeros(3,3); % (kroneker tensor products)
        for iIdx=1:size(idxs)
            vect = p(idxs(iIdx),:)-p(pIdx,:);
            CV = CV + kron(vect, vect');   
            [VEC,IGNORE] = svd( CV ); %#ok<NASGU>
            normals( pIdx, : ) = VEC(:,3)';
        end
        h = txtwaitbar(pIdx/size(p,1), h);
    end
    txtwaitbar('close',h);
    kdtree_delete(kdtree);
    varargout{1} = normals;
    
% full principal curvature estimation
elseif strcmp( TYPE, 'pcurv' )
    
    normals = zeros( size(P.points,1),3 );
    minCdir = zeros( size(P.points,1),3 );
    maxCdir = zeros( size(P.points,1),3 );
   
    
    h = txtwaitbar('init', 'principal directions: ');
    % for every point retrieve the kNN neighborhood, 
    % compute the sum of tensors and analyzes its 
    % eigenvalues to estimate the normal
    
    for pIdx = 1:size(p,1)
        idxs = kdtree_k_nearest_neighbors( kdtree, p(pIdx,:)', k);
        
        CV = zeros(3,3); % (kroneker tensor products)
        for iIdx=1:size(idxs)
            vect = p(idxs(iIdx),:)-p(pIdx,:);
            % add info to tensor
            CV = CV + kron(vect, vect');   
        end
        
        % extract local frame
        [VEC,IGNORE] = svd( CV ); %#ok<NASGU>
        normals( pIdx, : ) = VEC(:,3)';
        minCdir( pIdx, : ) = VEC(:,2)';
        maxCdir( pIdx, : ) = VEC(:,1)';

        % update progress bar
        h = txtwaitbar(pIdx/size(p,1), h);
    end
    txtwaitbar('close',h);
    varargout{1} = normals;
    varargout{2} = minCdir;
    varargout{3} = maxCdir;
        
end %end of pcloud_normal_estimate

