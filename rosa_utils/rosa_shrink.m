% updates the pset returning its new location and the confidence measure
function [pset, conf] = rosa_shrink( P, pset, k_kNN, CONFIDENCE_TH, NUM_ITER )


SHOW_RESULTS = false;
SHOW_PROGRESSIVE = true;

if SHOW_RESULTS || SHOW_PROGRESSIVE
    close all; figure(1), hold on; movegui('northeast'); 
    axis off; set( gcf, 'color', 'white' );
    hg = getappdata( pcloud_view( P ), 'hg' );
    mypoint( pset, '.r', 'markersize', 1, 'parent', hg );
end

%------------------------------------------------------------------------------%
%                                                                              %
%                          ALTERNATING PROJECTIONS                             %
%                                                                              %
% Alternate between MLS 1D collapse and surface (mah) based smoothing          % 
%                                                                              %
%------------------------------------------------------------------------------%
P_kdtree = kdtree_build( P.points );
h = txtwaitbar('init', 'Shrinking: ');
for iter = 1:NUM_ITER
    h = txtwaitbar(iter/NUM_ITER, h);
    
    %-- compute surface (mahalanobis) based smoothing
    newpset = zeros( size( pset ) );
    for i=1:size(pset,1)
        indxs = P.neighs{i};
        newpset(i,:) = mean( pset(indxs,:) ); %#ok<AGROW>
    end
    pset = newpset;
    
    %-- compute linearity statistics
    pset_kdtree = kdtree_build( pset );
    conf = zeros( size(pset,1), 1); % how much a point is a local line in current pset?
    for i=1:size(pset,1)
        neighIdxs = kdtree_k_nearest_neighbors( pset_kdtree, pset(i,:), k_kNN );
        neighbors = pset( neighIdxs,: );
        local_mean = mean(neighbors,1);
        neighbors(:,1) = neighbors(:,1) - local_mean(1);
        neighbors(:,2) = neighbors(:,2) - local_mean(2);
        neighbors(:,3) = neighbors(:,3) - local_mean(3);
        [ U, S ] = svd(neighbors');
        conf(i) = S(1,1)/(S(1,1)+S(2,2)+S(3,3));
    end
    
    if SHOW_PROGRESSIVE
        figure(2), clf, movegui('east'); 
        myscatter3( pset, 5, conf ); 
        axis off, axis equal; view(2);
        colorbar, pause(.1);
    end
    
    if iter == NUM_ITER, break, end;
    
    %-- compute linear projection
    newpset = pset;
    for i=1:size(pset,1)
        if conf(i)<CONFIDENCE_TH, continue, end; % do not try to embed unconfident sample
        neighIdxs = kdtree_k_nearest_neighbors( pset_kdtree, pset(i,:), k_kNN );
        neighbors = pset( neighIdxs,: );
        local_mean = mean(neighbors,1);
        neighbors(:,1) = neighbors(:,1) - local_mean(1);
        neighbors(:,2) = neighbors(:,2) - local_mean(2);
        neighbors(:,3) = neighbors(:,3) - local_mean(3);
        U = svd(neighbors');
        newpset(i,:) = U(:,1) * dot_product( U(:,1), pset(i,:)-local_mean ) + local_mean';
    end
    pset = newpset;
    kdtree_delete( pset_kdtree );     
end
txtwaitbar('close', h);
kdtree_delete( P_kdtree );

if SHOW_RESULTS
    figure(2), clf, movegui('east'); 
    myscatter3( pset, 5, conf ); 
    axis off, axis equal; view(2);
    colorbar, pause(.1);
end