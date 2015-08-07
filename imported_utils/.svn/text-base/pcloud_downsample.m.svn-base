function P_out = pcloud_downsample( P, delta, kdtree )

% which samples have already been touched
% 0: not touched
% 1: touched and kept
% 2: touched and discarded
status = zeros( size(P.points,1), 1 );

% retrieve kdtree or create a new one
localkdtree = false;
if ~exist('kdtree', 'var')
    kdtree = kdtree_build( P.points );
    localkdtree = true;
end

for pIdx=1:size(P.points,1)
    if status(pIdx)~=0, continue, end 
    neighIdxs = kdtree_ball_query( kdtree, P.points(pIdx,:)', delta );
    status( neighIdxs ) = 2;
    status( pIdx ) = 1;
end

% keep only what has been marked, (only if exists)
% TODO: use fieldnames(P) to copy any field
P_out.points  = P.points( status==1,: );
if isfield( P, 'normals' ), P_out.normals = P.normals( status==1,: ); end
if isfield( P, 'maxCdir' ), P_out.maxCdir = P.maxCdir( status==1,: ); end
if isfield( P, 'minCdir' ), P_out.minCdir = P.minCdir( status==1,: ); end
if isfield( P, 'color' ), P_out.color = P.color( status==1,: ); end

% delete the kdtree if it was created internally
if localkdtree == true
    kdtree_delete( kdtree );
end
