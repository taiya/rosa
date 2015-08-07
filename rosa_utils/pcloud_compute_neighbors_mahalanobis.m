% Converts the mahalanobis adj matrix to a pseudo 1-ring neighborhood cell array 
function neighs = pcloud_compute_neighbors_mahalanobis( MAHADJ, TH )

N = size(MAHADJ,1);
neighs = cell(N,0);

% convert to cell array "neigh" structure
% remember that weights are:
% ~0 for far points 
% ~1 for closeby points
h = txtwaitbar('init', 'Filtering neighborhood: ');
for i=1:N
    h = txtwaitbar(i/N, h);
    neighs{i} = find( MAHADJ(i,:)>TH ); 
end
txtwaitbar('close',h);
