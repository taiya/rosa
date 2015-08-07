% tests out the preprocessing of connectivity. it is used to decide over 
% parameter tuning. It computes the preprocessing and it shows visually
% how elements are connected to each other and which one is the output
% of a particular cutting plane

%---------- LOAD THE DATA ---------%
clc, clear, close all;
load ushape.preprocess.mat
th_mah = .02;
hg = getappdata(pointlab(P), 'hgtransform');
% IDX = find_closest(gca, P.points);
IDX = 3104;

%---------- SPECIFY THE CUT ---------%
P_cut = P.points(IDX,:);
V_cut = vector_normalize( [1,0,0] );
V_cut = [0.8123    0.2474    0.5282];
delta = .025;

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
