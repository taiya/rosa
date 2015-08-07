%--------------------------------------------------------------------------------------------------%
%                                           DCROSA iteration                                       %
%                                                                                                  %
% After everything converged in DCRosa, move every pset to centroid of pset of neighbors as        %
% implied by the original surface (uses mahalanobis neighborhood                                   %
%--------------------------------------------------------------------------------------------------%
function pset = rosa_dcrosa( P, pset, numiter_dcrosa )

set( figure(2), 'color', 'white' ); clf; movegui('east');
hg = getappdata(pcloud_view(P), 'hg');
hp = mypoint3( pset, '.r', 'parent', hg );

h = txtwaitbar('init', 'dcrosa: ');
for n=1:numiter_dcrosa
    % output iterations to file for visualization
    % K.points  = P.points;
    % K.normals = P.normals;
    % K.spcloud_write_off( K, 'dcrosa.off' );kele = pset;
    
     h = txtwaitbar(n/numiter_dcrosa, h);
    newpset = zeros( size( pset ) );
    for i=1:size(pset,1)'
        newpset(i,:) = mean( pset(P.neighs{i},:) ); %#ok<AGROW>
    end
    pset = newpset;
    delete( hp );
    hp = mypoint3( pset, '.r', 'parent', hg );
    pause(.05);    
end
txtwaitbar('close',h);    