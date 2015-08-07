%-- Unknown date --%
P.points ) );
pointlab( K )
pcloud_write_obj(K, 'standman_rec.off');
%-- 1/19/09  1:28 PM --%
pcloud_write_obj(K, 'standman_rec.obj');
pcloud_write_obj(K, 'standman_reconstructed3.obj');
activeidxs = setdiff( activeidxs, find_in_range( gca, P.points ) );
activeidxs = union( activeidxs, find_in_range( gca, P.points ) );
activeidxs = intersect( activeidxs, a );
activeidxs = intersect( activeidxs, find_in_range( gca, P.points ) );
activeidxs = union( activeidxs, find_in_range( gca, P.points ) );
activeidxs = setdiff( activeidxs, find_in_range( gca, P.points ) );
pointlab( K )
find_in_range( gca, K.points );
find_in_range( gca, K.points )
K
pointlab( K )
find_in_range( gca, K.points )
ans(:)
ans(:)'
!pointlab standman_reconstructed4.off
pcloud_write_obj( K, 'standman_reconstructed4.obj');
!pointlab standman_reconstructed4.off
pointlab( K )
find_in_range( gca, K.points )
ans(:)
ans(:)'
!pointlab standman_reconstructed4.off
pcloud_write_obj( K, 'standman_reconstructed4.obj');
P = pcloud_read_off('standman_skeleton.off');
pcloud_write_obj('standman_prerosa.off');
pcloud_write_obj(P,'standman_prerosa.off');
clc
clear
activeidxs = union( activeidxs, find_in_range( gca, P.points ) );
hg = getappdata( pointlab(P), 'hgtransform' );
activeidxs = union( activeidxs, find_in_range( gca, P.points ) );
activeidxs = setdiff( activeidxs, find_in_range( gca, P.points ) );
skel
!pointlab woman_reconstructed.off
pcloud_write_obj( K, 'woman_reconstructed.obj' );
pcloud_read_off('woman_skeleton.off');
P = pcloud_read_off('woman_skeleton.off');
pcloud_write_obj(P, 'woman_prerosa.obj');
%-- 2/3/09  3:01 PM --%
edit kdtree_nearest_neighbor.m
edit kdtree_k_nearest_neighbor.cpp
edit ../matlibs/kdtree/kdtree_nearest_neighbor.cpp
edit ../matlibs/kdtree/kdtree_ball_query.cpp
edit ../matlibs/kdtree/kdtree_nearest_neighbor.cpp
cd ../matlibs/kdtree/
!make
clc
clear
edit ../matlibs/kdtree/kdtree_nearest_neighbor.cpp
edit ../matlibs/kdtree/kdtree_nearest_neighbor.m
edit ../matlibs/kdtree/CHANGES
%-- 2/23/09  3:46 PM --%
doc
%-- 2/23/09  6:23 PM --%
%-- 3/2/09  2:57 PM --%
path
man path
help path
clc
%-- 3/2/09  3:17 PM --%
path
%-- 3/2/09  3:18 PM --%
path
%-- 3/2/09  3:18 PM --%
path
help addpath
addpath /Users/ata2/Desktop/TriLAB_1.0/
help mesh_read_smf
M = zeros(2,2);
M(1,1) = 'a';
M(2,2) = 1
M(2,2) = 'b'
M(2,2) = 'bdd'
M(2,1) = 'bd'
M(1) = 'as';
M(1,:) = 'as';
M = zeros(3,10);
M(1,:) = 'hello there'
M(1,:) = 'hello therea'
M(1,:) = 'hello ther'
M(1,:) = 'trilab is awesome';
M = zeros(3,17);
M(1,:) = 'trilab is awesome';
M(2,:) = 'get your own copy';
M(3,:) = 'download it!!';
C = cell(3,1);
C{1} = 'trilab is awesome';
C{2} = 'get your own copy';
C{3} = 'download it!!';
disp( C )
disp( M  )
M = mesh_read_smf('homer.smf');
M.VIF = mesh_vertex_incident_faces(M);
M
M = mesh_read_smf('homer.smf');
clc, clear
M = mesh_read_smf('homer.smf');
dbstop if error
M = mesh_read_smf('homer.smf');
addpath( '/Users/ata2/workspace/matlibs/common/');
M = mesh_read_smf('homer.smf');
M.VIF = mesh_vertex_incident_faces(M);
disp( M.VIF{0} )
disp( M.VIF{1} )
disp( M.VIF{1}' )
disp( M.VIF{2}' )
clc, clear, close all;
M = mesh_read_smf('homer.smf');
mesh_read_smf('homer.smf');
M = mesh_read_smf('homer.smf');
mesh_view( M );
opengl
opengl info
%-- 3/2/09  4:55 PM --%
help hgtransform
M = mesh_read_smf('rabbit.smf');
%-- 3/2/09  8:04 PM --%
%-- 6/16/09  9:11 AM --%
sk_neighs
neighs
P.neighs{currcors}
A
imagesc(A)
size(A)
A = sparse( length(skelver), length(skelver) );
A
neighs
sk_neighs
corres(neighs)
find( corres==i )
find( corres==1 )
find( corres==2 )
plot( corres )
sk_neighs
A
imagesc(A)
mypoint3( skelver(corres==0,:), '.g', 'parent', hg )
size(corress)
size(corres)
mypoint3( P.points(corres==0,:), '.g', 'parent', hg )
neighs
sktri
load DATA/fertility_4n.dcrosa.mat;
load test_newcollapse.mat
whos
clc
mypoint3( skelver, '.r', 'parent', hg );
for i=1:size(A,1)
for j=1:size(A,2)
if( A(i,j)==1 )
myedge3(skelver(i,:), skelver(j,:), 'parent', hg);
end
end
end
skelver
hpts = mypoint3( skelver, '.r', 'parent', hg );
heds = [];
for i=1:size(A,1)
for j=1:size(A,2)
if( A(i,j)==1 )
heds(end+1) = myedge3(skelver(i,:), skelver(j,:), 'parent', hg);
end
end
end
myedge3( skelver(edge(1),:), skelver(edge(2),:), 'color', 'red', 'parent', hg )
mypoint3( skelver(edge(1),:), 'color', 'green', 'parent', hg )
edge1
edge
delete(hpts);
delete(heds);
mypoint3( skelver(edge(1),:), 'color', 'green', 'parent', hg )
skelver(edge(1),:)
mypoint3( skelver(edge(1),:), 'color', 'green', 'parent', hg )
skelver(edge(1),:)
mean( skelver( edge,: ) )
mypoint3( skelver(edge(1),:), 'color', 'green', 'parent', hg )
edge(1)
mypoint3( skelver(edge(1),:), 'color', 'green', 'parent', hg )
mypoint3( skelver(edge(1),:), '*g', 'markersize', 10, 'parent', hg )
mypoint3( skelver(edge(2),:), '*g', 'markersize', 10, 'parent', hg )
edge(2)
edge(1)
edge(2)
skeds
edge(2)
idx
edge
idx
skeds(53)
skeds(53,:)
skcst
hpts = mypoint3( skelver, '.r', 'parent', hg );
heds = [];
for i=1:size(A,1)
for j=1:size(A,2)
if( A(i,j)==1 )
heds(end+1) = myedge3(skelver(i,:), skelver(j,:), 'parent', hg);
end
end
end
mypoint3(pset,'.r','parent', hg)
clc, clear, close all
load test_newcollapse_woman.mat
clc, clear, close all
load test_newcollapse_woman.mat
hg = getappdata( pcloud_view(P), 'hg' );
find(corres==0)
mypoint3( pset(corres==0,:), '.r', 'parent', hg )
mypoint3( pset(corres==0,:), '*g', 'parent', hg )
mindst(corress==0)
mindst(corres==0)
minpar(corres==0)
mypoint3( pset(corres==0,:), '*g', 'parent', hg )
corress==0
corres==0
mypoint3( pset(corres==0,:), '*g', 'parent', hg )
mypoint3( pset(corres==0,:), '.r', 'markersize', 10, 'parent', hg );
pset(corres==0,:)
find_closest(gca,skelver)
mypoint3( skelver(36,:), '*g', 'parent', hg )
mypoint3( skelver(36,:), '*g', 'markersize', 20, 'parent', hg )
find_closest(gca,skelver)
mypoint3( skelver(1,:), '*g', 'markersize', 20, 'parent', hg )
mypoint3( skelver(18,:), '*g', 'markersize', 20, 'parent', hg )
mypoint3( skelver(25,:), '*g', 'markersize', 20, 'parent', hg )
find_closest(gca,skelver)
nearDst
cross3( (SET(pIdx,:)-p), v )
SET(pIdx,:)
SET(pIdx,:)-p
v
M_tr
currp
A
B
B(1:3)-A(1:3)
vector_normalize( B(1:3)-A(1:3) )
vector_normalize( [0 0 -10] )
vector_normalize( [0 0 -101] )
B(1:3)
B(1:3)-A(1:3)
vector_normalize( [0 0 -101]' )
find_closest(gca,skelver)
vector_normalize( [0 0 -101]' )
find_closest(gca,skelver)
skelver
skelver(21,:)
find_closest(gca,skelver)
A(21,:)
A(:,21)
mypoint3( skelver(21,:), '*g', 'markersize', 20, 'parent', hg )
mypoint3( skelver(1,:), '*g', 'markersize', 20, 'parent', hg )
A(21,1)
A(1,21)
A(:,21)
A(21,1)
A
A(21,1)
A(21,:)
find_closest(gca,skelver)
mypoint( pset(corresp==21), '.r', 'parent', hg )
mypoint( pset(corres==21), '.r', 'parent', hg )
mypoint3( pset(corres==21), '.r', 'parent', hg )
mypoint3( pset(corres==21,:), '.r', 'parent', hg )
mypoint3( P.points(corres==21,:), '.r', 'parent', hg )
mypoint3( P.points(corres==22,:), '.g', 'parent', hg )
mypoint3( P.points(corres==20,:), '.g', 'parent', hg )
find_closest(gca,skelver)
mypoint3( P.points(corres==1,:), '.r', 'parent', hg )
mypoint3( P.points(corres==2,:), '.r', 'parent', hg )
mypoint3( P.points(corres==3,:), '.r', 'parent', hg )
mypoint3( skelver(1,:), '*g', 'parent', hg )
mypoint3( P.points(corres==1,:), '.r', 'parent', hg )
length(skelver)
P
load horse.dcrosa.mat
whos
neighs
P
test_newrecenter.m
edit test_newrecenter.m
i
skelver(i,:)
dbstop if error
%-- 6/16/09  4:15 PM --%
clc
edit test_zahid.m
test_zahid
cc
clc
%-- 7/29/09 12:18 PM --%
edit rosa_lineextract.m
run( sprintf('DATA/%s.m',filename) ); % refresh options
whos
filename
edit rosa_recenter.m
edit DATA/indoladyS5.m
P
P.corresp
P
dbstop if warning
idxs
P.skelver
P.skel_adj
clc
P
P.normals
P
pcloud_write_off(P,'simplejoint.off');
!pointlab simplejoint.off
save(['DATA/',filename,'.preprocess.mat'], 'P', 'MAHADJ');
load DATA/simplejoint.preprocess.mat
whos
clear
load DATA/simplejoint.preprocess.mat
whos
[filename,'.m']
run([filename,'.m'])
run(sprintf(filename,'.m'()
run(sprintf(filename,'.m'))
run(sprintf(filename,'.m'))run(sprintf(filename,'.m'))
run(sprintf(filename,'.m'))run(sprintf(filename,'.m')
run(sprintf(filename,'.m'))
run(sprintf('%s.m',filename))
run(sprintf('test/%s.m',filename))  %reload options
do
doc
run(sprintf('./%s.m',filename))  %reload options
pathtool
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
load([filename,'.dcrosa.mat']);
save([filename,'.shrink.mat']);
clc, clear, close all;
%--- which file we should run on
filename = 'camel_1n';
run(sprintf('./%s.m',filename))
clc
edit RESULTS/simplejoint/simplejoint.m
!pointlab camel_1n.off
dasds
P
.
%-- 7/29/09  3:45 PM --%
clc
load([filename,'.shrink.mat']);
sample_radius
%-- 7/29/09  4:09 PM --%
clc
!pointlab fertility_1n.off
dbstop if err
dbstop if error
continue
P.points(5936,:)-P.points(5893,:)
norm(ans)
!pointlab fertility_2n.off
load([filename,'.neighs.mat'] );
P.neighs
clc
MAHADJ(5936,5937)
MAHADJ(5937,5986)
MAHADJ(5986,5937)
norm( P.points(5986,:), P.points(5937,:) )
norm( P.points(5986,:)-P.points(5937,:) )
kdtree = kdtree_build( P.points );
pIdx = 5986
iIdx = 5937
p1 = P.points(pIdx,:);
v1 = P.normals(pIdx,:);
p2 = P.points(iIdx,:);
v2 = P.normals(iIdx,:);
weight1 = mahalanobis_leth( p1,v1,p2,v2,Radius );
weight1 = mahalanobis_leth( p1,v1,p2,v2,.25 );
weight1 = mahalanobis_leth( p1,v1,p2,v2,.25 )
weight1 = mahalanobis_leth( p2,v2,p1,v1,.25 )
pIdx
iIdx
hg = getappdata( pcloud_view(P), 'hg' );
mypoint3( P.points(5986,:), P.points(5937,:), 'parent', hg )
mypoint3( P.points(5986,:), 'parent', hg )
mypoint3( P.points(5986,:), 'parent', hg, '*g' )
mypoint3( P.points(5986,:), '*g', 'parent', hg )
mypoint3( P.points(5937,:), '*g', 'parent', hg )
pIdx = 5986
iIdx = 5937
p1 = P.points(pIdx,:);
v1 = P.normals(pIdx,:);
p2 = P.points(iIdx,:);
v2 = P.normals(iIdx,:);
weight1 = mahalanobis_leth( p1,v1,p2,v2,Radius );
Radius = .25
weight1 = mahalanobis_leth( p1,v1,p2,v2,Radius )
norm( p1-p2 + Fs*((p1-p2)*v1')*v1 )
Fs = 2;
norm( p1-p2 + Fs*((p1-p2)*v1')*v1 )
v1*v2'
k = 0;
dist = dist / Radius;
if dist<=1, k=2*dist^3-3*dist^2+1; end
dist = norm( p1-p2 + Fs*((p1-p2)*v1')*v1 );
k = 0;
dist = dist / Radius;
if dist<=1, k=2*dist^3-3*dist^2+1; end
k
dist
Radius
dist
norm( p1-p2 + Fs*((p1-p2)*v1')*v1 )
clc
find_closest( gca, pset )
figure,
hg = getappdata( pcloud_view(P), 'hg' );
mypoint3( P.points(6400,:), '.r', 'parent', hg );
pset
load([filename,'.drosa.mat'], 'P','pset');
find_closest( gca, pset )
figure,
hg = getappdata( pcloud_view(P), 'hg' );
mypoint3( P.points([3025 3022 3320 3471 2935 3020],:), '.r', 'parent', hg );
vset
P.normals = vset
pcloud_write_off( P, 'test.off' );
!pointlab test.off
find_closest( gca, pset )
vset(3104,:)
P.points(3104,:)
edit test_my.m
S
V
D
S
V
D
x
clc
x
doc svd
U(:,1)
-U(:,1)
norm(ans)
mypoint( [0.89, 0.45] )
hold on
mypoint( [0.89, 0.45] )
mypoint( [0.89, 0.45],  )
mypoint( [0.89, 0.45], '*r' )
doc svd
figure(1), movegui('northeast');
hg = getappdata( pcloud_view(P), 'hg' );
mypoint3( P.points(P.neighs{1201},:), '.r', 'parent', hg );
figure(1), movegui('northeast');
hg = getappdata( pcloud_view(P), 'hg' );
mypoint3( P.points(P.neighs{1201},:), '.r', 'parent', hg );
%-- 7/30/09 10:53 AM --%
clc
which rosa_drosa
pathtool
which rosa_drosa
set( figure(1), 'color', 'white' ); clf; movegui('northeast');
hg = getappdata(pcloud_view(P), 'hg');
mypoint
mypoint3( P.points(pIdx,:), '*g', 'parent', hg )
myline3( P.points(pIdx,:), vset(pIdx,:), 'parent', hg )
myline3( P.points(pIdx,:), vset(pIdx,:), .1, 'parent', hg )
myline3( P.points(pIdx,:), vnew(pIdx,:), .1, 'parent', hg )
P.surf_neighs{1}
P.surf_neighs{2}
P.surf_neighs{3}
mypoint3( P.points(P.surf_neighs{1},:), '.r', 'parent', hg )
myline3( P.points(P.surf_neighs{1},:), vnew(P.surf_neighs{1},:), .1, 'parent', hg )
myline3( P.points(P.surf_neighs{1}(1),:), vnew(P.surf_neighs{1}(1),:), .1, 'parent', hg )
myline3( P.points(P.surf_neighs{1}(2),:), vnew(P.surf_neighs{1}(2),:), .1, 'parent', hg )
P.surf_neighs{1}(2)
vnew(P.surf_neighs{1}(2),:)
set( figure(1), 'color', 'white' ); clf; movegui('northeast');
hg = getappdata(pcloud_view(P), 'hg');
mypoint3( P.points(pIdx,:), '*g', 'parent', hg )
myline3( P.points(pIdx,:), vset(pIdx,:), 'parent', hg )
myline3( P.points(pIdx,:), vset(pIdx,:), .1, 'parent', hg )
myline3( P.points(pIdx,:), vnew(pIdx,:), .1, 'parent', hg )
vset(pIdx,:)
vnew(pIdx,:)
myline3( P.points(pIdx,:), vnew(pIdx,:), .1, 'parent', hg )
myline3( P.points(pIdx,:), vnew(pIdx,:), .1, 'color', 'red', 'parent', hg )
myline3( P.points(P.surf_neighs{1},:), vnew(P.surf_neighs{1},:), .1, 'parent', hg )
vnew(P.surf_neighs{1},:)
P.points(P.surf_neighs{1},:)
for i=1:length(P.surf_neighs), myline3( P.points(P.surf_neighs{1}(i),:), vnew(P.surf_neighs{1}(i),:), .1, 'parent', hg ), end
for n=1:length(P.surf_neighs), myline3( P.points(P.surf_neighs{1}(n),:), vnew(P.surf_neighs{1}(n),:), .1, 'parent', hg ), end
U
myline3( P.points(pIdx,:), vset(pIdx,:), .1, 'color', 'green', 'parent', hg )
vset(pIdx,:) = U(:,1)
vset(pIdx,:) = U(:,1);
myline3( P.points(pIdx,:), vset(pIdx,:), .1, 'color', 'green', 'parent', hg )
doc svn
doc svd
[U,S,V] = svd( ellips' )
[U,S,V] = svd( ellips',0 )
M = [ 1 0; -1 0.1; 1, 0.1; -1 -.1 ]
mypoint( M )
mypoint( M, '.' )
M = [M;-M];
[U,S,V] = svn(M')
[U,S,V] = svd(M')
M = [ 1 0 1 ; -1 0.1 -1 ; 1, 0.1 1; -1 -.1  -1]
mypoint3(M,'.r')
xlim([-1,1]), ylim([-1,1]), zlim([-1,1])
mypoint3(M,'.r')
xlim([-1,1]), ylim([-1,1]), zlim([-1,1])
zlabel('z')
M = [M;-M];
[U,S,V] = svd(M')
mypoint3( U(:,1), '*g' )
U(:,1)
mypoint3( U(:,1)', '*g' )
mypoint3(M,'.r')
xlim([-1,1]), ylim([-1,1]), zlim([-1,1])
mypoint3( U(:,1)', '*g' )
hold on
xlim([-1,1]), ylim([-1,1]), zlim([-1,1])
mypoint3(M,'.r')
mypoint3( U(1,:)', '*g' )
mypoint3( U(1,:), '*g' )
U
U(1,:)*U(2,:)'
U(1,:)*U(3,:)'
U(:,1)*U(:,2)'
U(:,1)*U(:,2)
U(:,1)'*U(:,2)
U(:,1)'*U(:,3)
edit test.m
edit mytest.m
U
mypoint( M )
mypoint( M, '.r' )
edit pcloud_write_off.m
help pcloud_downsample
edit pcloud_downsample
P
pointlab(P)
P
pointlab(P)
P
pointlab(P)
P
pcloud_write_off('ushape1.off');
pcloud_write_off(P,'ushape1.off');
!pointlab ushape1.off
newpoints
P.points(kdtree_k_nearest_neighbors(kdtree, P.points(i,:),7),: )
%-- 7/30/09  1:06 PM --%
P
!pointlab ushape1.off
P
pointlab(P)
P = pcloud_downsample( P, .05 );
pointlab(P)
P.normals = pcloud_normal_estimate( P, [], 'hoppe', 20 );
pcloud_write_off(P,'ushape1.off');
!pointlab ushape.off
clc
hg = getappdata(pcloud_view(P), 'hg');
mypoint( P.points(P.neighs{1},:), '.r' )
hg = getappdata(pcloud_view(P), 'hg');
mypoint( P.points(P.neighs{1},:), '.r' )
mypoint( P.points(P.neighs{1},:), '.r', 'parent', hg )
!pointlab ushape.off
find_closest(gca, pset)
hg = getappdata(pcloud_view(P), 'hg');
mypoint( P.points(2120,:), '.r', 'parent', hg );
mypoint( pset, '.r', 'parent', hg );
P.normals = vset;
pcloud_write_off( P, 'test.off');
!pointlab test.off
P.skele = pset
pcloud_write_off( P, 'test.off');
!pointlab test.off
idxs = find_in_range( gca, pset )
hg = getappdata(pcloud_view(P), 'hg');
for i=1:length(idxs), mypoint( P.points(idxs(i),:), '.r' ); end
close all
for i=1:length(idxs), mypoint( P.points(idxs(i),:), '.r' ); end
hg = getappdata(pcloud_view(P), 'hg');
for i=1:length(idxs), mypoint( P.points(idxs(i),:), '.r', 'parent', hg ); end
for i=1:length(idxs), myline( P.points(idxs(i),:), vset(idxs(i),:), .4, 'parent', hg ); end
isoncut = pcloud_isoncut( P.points, P.points(idxs(1),:), vset(idxs(1),:), delta );
mypoint( P.points(isoncut,:), '.g', 'parent', hg );
isoncut
rosa_compute_active_samples
P_cut = P.points(idxs(1),:);
V_cut = vset(idxs(1),:);
%---------- COMPUTE THE CUT ---------%
out_indxs = [];
isoncut = pcloud_isoncut( P.points, P_cut, V_cut, delta );
queue = IDX;
while ~isempty(queue)
curr = queue(1);
queue(1) = [];
isoncut( curr ) = 2;
out_indxs(end+1) = curr; %#ok<AGROW>
indxs = find(MAHADJ(curr,:)>th_mah);
indxs = indxs( isoncut(indxs)==1 );
isoncut( indxs ) = 3;
queue = [queue, indxs]; %#ok<AGROW>
if isempty(indxs), continue, end;
end
mypoint( P.points(out_indxs,:), '.g', 'parent', hg );
IDX = idxs(1)
%---------- COMPUTE THE CUT ---------%
out_indxs = [];
isoncut = pcloud_isoncut( P.points, P_cut, V_cut, delta );
queue = IDX;
while ~isempty(queue)
curr = queue(1);
queue(1) = [];
isoncut( curr ) = 2;
out_indxs(end+1) = curr; %#ok<AGROW>
indxs = find(MAHADJ(curr,:)>th_mah);
indxs = indxs( isoncut(indxs)==1 );
isoncut( indxs ) = 3;
queue = [queue, indxs]; %#ok<AGROW>
if isempty(indxs), continue, end;
end
mypoint( P.points(out_indxs,:), '.g', 'parent', hg );
!pointlab test2.off
repmat( [0,1], 2, 1 )
dbstop if error
e1
alpahs
alphas
repmat( M(1,:), length(vIdxs), 1 )
P.normals(vIdxs,:)
P.normals(vIdxs,:).*repmat( M(2,:), length(vIdxs), 1 )
sum( P.normals(vIdxs,:).*repmat( M(2,:), length(vIdxs), 1 ), 2 )
!pointlab test2.off
idxs = find_in_range( gca, pset )
idxs = find_in_range( gca, pset );
hg = getappdata(pcloud_view(P), 'hg');
for i=1:length(idxs), mypoint( P.points(idxs(i),:), '.r', 'parent', hg ); end
set( figure(1), 'color', 'white' ); clf; movegui('northeast');
hg = getappdata(pcloud_view(P), 'hg');
find_closest(gca, pset)
vnew(pIdx,:) = compute_symmetrynormal( P.normals( indxs, : ) )';
vec
lam
IDX
vnew(pIdx,:) = compute_symmetrynormal( P.normals( indxs, : ) )';
lam
IDX
hg
vec
indxs
P.points(indxs,:)
P.points = P.points(indxs,:);
P.normals = P.normals(indxs,:);
P
P.neighs = [];
P
P.surf_neighs = [];
save matlab.mat P
v
lam
close all
!pointlab ushape.off
%-- 7/31/09 10:32 AM --%
load([filename,'.drosa.mat'], 'P','pset');
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
clc
find_in_range(gca, pset)
pset
idxs = find_in_range(gca, pset)
idxs = find_closest(gca, pset)
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
idxs = find_closest(gca, pset)
edit symmnormal_variance.m
idxs = find_closest(gca, pset)
dbstop if error
normals
symm_nor
repmat( symm_nor(:), size(normals,1), 1 )
idxs = find_closest(gca, pset)
vvar(776)
vvar(930)
sqrt(vvar(776))
sqrt(vvar(776))/sqrt(vvar(930))
(vvar(776))/vvar(930)
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
idxs = find_in_range( gca, pset )
hg = getappdata(pcloud_view(P), 'hg');
idxs = find_in_range( gca, pset )
mypoint( pset, '.r', 'parent', hg );
idxs = find_in_range( gca, pset )
mypoint( P.points(idxs,:), '.b', 'parent', hg )
edit symmnormal_smooth.m
edit compute_symmetrynormal
edit compute_symmetrynormal.m
clc
hg = getappdata(pcloud_view(P), 'hg');
mypoint( pset, '.r', 'parent', hg );
edit symmnormal_smooth_demo.m
vset
pcloud_view( P )
P
size(v)
size(p)
vset
edit vector_normalize.m
doc arrayfun
continue
doc arrayfun
edit matrixfun.m
edit arrayfun.m
doc function pointer
edit matrixfun_demo.m
M1
norm(M1(1,:))
norm(M1(2,:))
norm(M1(3,:))
norm(M1(4,:))
vset
%-- 7/31/09  3:37 PM --%
vset
P.points
vset
P.points
M
V(:,3)
vec
lam
sign( randn(length(P.points),1 ) )
%-- 8/14/09 11:07 AM --%
!pointlab iteration_1.off
!pointlab iteration_2.off
!pointlab iteration_3.off
!pointlab iteration_6.off
!pointlab iteration_10.off
find_in_range( gca, pset )
vset( 5716,: )
vset( 3156,: )
vset( 5755,: )
pset( 5755,: )
pset( 3156,: )
P.neighs(5716,:)
P.neighs(5716)
P.neighs{5716}
surf_kdtree = kdtree_build( P.points );
pIdx = 5716
neighs = kdtree_k_nearest_neighbors( surf_kdtree, P.points(pIdx,:), 6);
neighs = kdtree_k_nearest_neighbors( surf_kdtree, P.points(pIdx,:), 6)
pset( 5716, :)
vset( 5716, :)
pset
find_in_range( gca, pset )
P.neighs(5745,:)
P
P.neighs{5745}
P.neighs{730}
P.neighs{5745}
find_in_range( gca, pset )
P.neighs{730}
P.neighs{5755}
P.neighs{3146}
P.neighs{3156}
P.neighs{5716}
neighs
P.neighs{neighs}
length( P.neighs{5716} )
length( P.neighs{neighs} )
norm( P.points(939,:)-P.points(938.:) )
norm( P.points(939,:)-P.points(938,:) )
P.neighs{939}
alpha_recenter
dbstop if error
eucl_center
proj_center
eucl_center
clc
continue
!pointlab woman.offf
!p
ointlab woman.offf
ointlab woman.of
!pointlab woman.off
!pointlab camel_2n.off
cur
e
e.message
!pointlab giraffe.off
!pointlab horse.off
clc
max( pset )
min( pset )
%-- 8/19/09 10:08 AM --%
clc
pathtool
mex pcloud_isoncut.cpp
clc
!make
!man cp
!make
clc
which closest_projection_point.m
!svn mv ../matlibs/pointlab/closest_projection_point.m ./rosa_utils/
!svn commit -m "rosa release... WIP"
cd imported_utils/
!ln -s ../../matlibs/common/dot_product.m
!ln -s ../../matlibs/common/create_orthonormal_frame.m
!svn mv ../../matlibs/common/mahalanobis_leth.m ../rosa_utils/
!ln -s ../../matlibs/common/txtwaitbar.m
!make
!ln -s ../../matlibs/pointlab/pcloud_view.m
!ln -s ../../matlibs/common/mypoint3.m
clc
!ln -s ../../matlibs/common/myedge3.m
!ln -s ../../matlibs/common/euclidean_distance.m
clc
cd .
cd ..
