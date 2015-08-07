% Mahalanobis distance adj matrix with kernel "Radius"
% 
function MAHADJ = pcloud_adj_matrix_mahalanobis(P, Radius, th_mah)

kdtree = kdtree_build( P.points );
MAHADJ = sparse(length(P.points), length(P.points));
h = txtwaitbar('init', 'Mahalanobis ADJ: ');
for pIdx=1:length(P.points);
    h = txtwaitbar(pIdx/length(P.points), h);
    p1 = P.points(pIdx,:);
    v1 = P.normals(pIdx,:);
    
    indxs = kdtree_ball_query( kdtree, P.points(pIdx,:), Radius );
    for iIdx=indxs'
        p2 = P.points(iIdx,:);
        v2 = P.normals(iIdx,:);
        weight1 = mahalanobis_leth( p1,v1,p2,v2,Radius );
        weight2 = mahalanobis_leth( p2,v2,p1,v1,Radius );
        
        % choose minimum between the two distances
        weight = min( weight1, weight2 );
        %if weight > th_mah
            MAHADJ( pIdx, iIdx ) = weight;
            MAHADJ( iIdx, pIdx ) = weight;
        %end
    end
end
txtwaitbar('close',h);
kdtree_delete( kdtree );