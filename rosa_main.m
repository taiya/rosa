
%% which file we should run on
clc, clear, close all;
filename = 'fertility_2n';
% rand('twister',10);

%% EXTRACT NEIGHBORHOOD
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    P = pcloud_read_off([filename,'.off']);        
    MAHADJ = pcloud_adj_matrix_mahalanobis(P, radius_mah);
    save([filename,'.preprocess.mat'], 'P', 'MAHADJ');
end

%% FILTER THE MAHALANOBIS NEIGHBORHOOD
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    load([filename,'.preprocess.mat'], 'P', 'MAHADJ');
    P.neighs = pcloud_compute_neighbors_mahalanobis( MAHADJ, th_mah );
    save([filename,'.neighs.mat'], 'P');
end

%% RUN DROSA
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    load([filename,'.neighs.mat'] );
    [P, pset, vset, vvar] = rosa_drosa( P, delta, numiter_drosa, k_kNN);
    save([filename,'.drosa.mat'], 'P', 'pset', 'vset');
end 

%% RUN DCROSA
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    load([filename,'.drosa.mat'], 'P','pset'); 
    pset = rosa_dcrosa( P, pset, numiter_dcrosa );   
    save([filename,'.dcrosa.mat'], 'P', 'pset');
end

%% RUN EUCLIDEAN-SHRINK
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    load([filename,'.dcrosa.mat'], 'P', 'pset'); 
    % [pset, conf] = rosa_shrink( P, pset, k_kNN, shrink_conf_th, shrink_iter );
    save([filename,'.shrink.mat']);
end

%% GRAPH EXTRACT
if 1
    clc, run(sprintf('./%s.m',filename))  %reload options
    load([filename,'.shrink.mat'], 'P', 'pset'); 
    P = rosa_lineextract( P, pset, sample_radius, k_kNN );
    save([filename,'.linegraph.mat']);    
end

%% RECENTERING
if 1
    load([filename,'.linegraph.mat']); 
    clc, run(sprintf('./%s.m',filename))  %reload options
    [P,SK] = rosa_recenter( P, alpha_recenter );    
    curve_write_cg( SK, [filename,'.skeleton.cg'] );
    save([filename,'.recenter.mat']);    
end