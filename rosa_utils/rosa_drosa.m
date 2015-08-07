function [P, pset, vset, vvar] = rosa_drosa( P, delta, numiter_drosa, k_kNN )

%--------------------------------------------------------------------------------------------------%
%                                        INITIALIZE ROSA
%--------------------------------------------------------------------------------------------------%
[pset,vset] = rosa_initialize(P, 'random');

%--------------------------------------------------------------------------------------------------%
%                                               ROSA
%--------------------------------------------------------------------------------------------------%
% TESTING: build neighborhood
surf_kdtree = kdtree_build( P.points );
P.surf_neighs = cell(0,length(P.points));
for pIdx =1:length(P.points)
    P.surf_neighs{pIdx} = kdtree_k_nearest_neighbors( surf_kdtree, P.points(pIdx,:), k_kNN);
end
kdtree_delete(surf_kdtree);


%DEBUG
% set( figure(1), 'color', 'white' ); clf; movegui('northeast');
% hg = getappdata(pcloud_view(P), 'hg');

h = txtwaitbar('init', 'Iteration: ');
for n=1:numiter_drosa
    h = txtwaitbar(n/numiter_drosa, h);
    vnew = zeros( size(vset) );
       
    % TEMP.points = P.points;
    % TEMP.skele  = vset;
    % TEMP.normals = P.normals;
    % pcloud_write_off( TEMP, sprintf('test2.off') );
    
    % for every sample
    h2 = txtwaitbar('init', 'Update VSET: ');
    for pIdx=1:length(pset)        
        h2 = txtwaitbar(pIdx/size(pset,1), h2);
        indxs = rosa_compute_active_samples( P, pIdx, pset(pIdx,:), vset(pIdx,:), delta );
        vnew(pIdx,:) = compute_symmetrynormal( P.normals( indxs, : ) )';
        vvar(pIdx,:) = symmnormal_variance( vnew(pIdx,:), P.normals(indxs,:) );
                
%         mypoint( P.points(pIdx,:), '*g', 'parent', hg );
%         hdel = mypoint( P.points(indxs,:), '.r', 'parent', hg );
%         hlin = myline( P.points(pIdx,:), vset(pIdx,:), .1, 'color', 'green', 'parent', hg );
%         hlin(2) = myline( P.points(pIdx,:), vnew(pIdx,:), .1, 'color', 'red', 'parent', hg );
%         delete( hdel );
%         delete( hlin );
        
        %%%%%DEBUG: ouput sample set
%         centroid = closest_projection_point( P.points(indxs,:), P.normals(indxs,:),'optimization')';
%         if ~isempty(centroid), 
%             TEMP.skele(pIdx,:) = centroid; 
%         end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    txtwaitbar('close', h2);

%     pcloud_write_off( TEMP, sprintf('iteration_%d.off',n) );
    

    % variance weight samples
    vvar = 1./(vvar.^4+.00001);   
    vset = vnew;
         
    %%%% DEBUG
    for i=1:3 % several passes of smoothing?
        h2 = txtwaitbar('init', 'Smooth VSET: ');
        for pIdx=1:length(pset)
            h2 = txtwaitbar(pIdx/size(pset,1), h2);
            neighs = P.surf_neighs{pIdx};
            vset(pIdx,:) = symmnormal_smooth(vset(neighs,:), vvar(neighs,:));
            % vset(pIdx,:) = symmnormal_smooth(vset(neighs,:), ones(length(neighs),1));
        end
        txtwaitbar('close', h2);
        vnew = vset;
    end


    % pcloud_write_off( TEMP, sprintf('iteration_%d.off',n) );  
end
txtwaitbar('close', h);


%--------------------------------------------------------------------------------------------------%
%                                          COMPUTE POSITIONS
%--------------------------------------------------------------------------------------------------%
removeidx = [];
h2 = txtwaitbar('init', 'POS: ');
for pIdx=1:length(pset)
    h2 = txtwaitbar(pIdx/length(pset), h2);
    indxs = rosa_compute_active_samples( P, pIdx, pset(pIdx,:), vset(pIdx,:), delta );
    centroid = closest_projection_point( P.points(indxs,:), P.normals(indxs,:),'optimization')';
    if ~isempty(centroid), 
        pset(pIdx,:) = centroid; 
    else
        removeidx(end+1) = pIdx; %#ok<AGROW>
    end
end      
txtwaitbar('close', h2);

%%% VIZ
set( figure(1), 'color', 'white' ); clf; movegui('northeast');
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
pause(.1);

% given a cutting plane orientation computes the subset of samples 
% belonging to the current plane
% 
% Parameters:
%   - P: the point cloud data structure
%   - P_cut: the cut offset
%   - V_cut: the cut direction
%   - delta: the cut "thickness"
function out_indxs = rosa_compute_active_samples(P, i, P_cut, V_cut, delta)
    out_indxs = [];
    isoncut = pcloud_isoncut( P.points, P_cut, V_cut, delta );
    queue = i;
    while ~isempty(queue)
        curr = queue(1);
        queue(1) = [];
        isoncut( curr ) = 2; % mark as touched
        out_indxs(end+1) = curr; %#ok<AGROW>

        %%% DEBUG
        % mypoint( P.points(curr,:), '*r' );

        % Add neighbors to queue
        indxs = P.neighs{curr};
        indxs = indxs( isoncut(indxs)==1 );
        isoncut( indxs ) = 3;
        queue = [queue, indxs]; %#ok<AGROW>
    end
end

function [p, v] = rosa_initialize( P, TYPE )
    if ~exist( 'TYPE', 'var' )
       TYPE = 'random'; 
    end
    if strcmp( TYPE, 'random' )
        p = P.points;
        v = zeros( size(p) );
        % sample a random cutting plane perpendicular to the normal
        h2 = txtwaitbar('init', 'INIT: ');
        for k=1:size(P.points,1)
            h2 = txtwaitbar(k/length(P.points), h2);
            
            M = create_orthonormal_frame( P.normals(k,:) );
            v(k,:) = M(2,:);
        end
        txtwaitbar('close', h2);
        
    % initialize a cut along the max curvature
    elseif strcmp( TYPE, 'maxcurv' )
        p = zeros( size(P.points) );
        v = zeros( size(P.normals) );

        % create a frame aligned with max curvature and normal
        for k=1:size(P.points,1)
            D = cross_product( P.normals(k,:), P.maxCdir(k,:) );
            v(k,:) = vector_normalize( D );
            p(k,:) = P.points(k,:);
        end
    else
        error('type must be either "random" or "maxcurv"');    
    end
end


end