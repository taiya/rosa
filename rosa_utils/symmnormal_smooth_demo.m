clc, clear, close all;
P = pcloud_read_off('symmetrynormal_smooth_demo.off');
P.points = pcloud_normalize( P );
P.points(:,2) = P.points(:,3);
P.points(:,3) = 0;

vset = ( (ones( length(P.points), 3 ) + .5*randn(length(P.points), 3)) );
signswaps = sign( randn(length(P.points),1 ) );
vset(:,3) = 0;
vset = matrixfun(@vector_normalize, vset);
for i=1:length(vset)
    vset(i,:) = vset(i,:).*signswaps(i);
end


surf_kdtree = kdtree_build( P.points );
P.surf_neighs = cell(0,length(P.points));
for pIdx =1:length(P.points)
    P.surf_neighs{pIdx} = kdtree_k_nearest_neighbors( surf_kdtree, P.points(pIdx,:), 8);
end
kdtree_delete(surf_kdtree);
hold on;

% hg = getappdata( pcloud_view(P), 'hg' );
% myline( P.points, vset, .05, 'parent', hg );
for i=1:100
    hdel = myline(P.points, vset, .07); view(2);
    hpts = mypoint3(P.points, '.r'); view(2);
    delete( hdel );
    delete( hpts );
    
    for pIdx=1:length(P.points)
        neighs = P.surf_neighs{pIdx}; 
        vset(pIdx,:) = symmnormal_smooth(vset(neighs,:), ones(length(neighs),1));
    end
end