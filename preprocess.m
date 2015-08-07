% % P.points = pcloud_normalize( P );
% filename = 'simplejoint.off';
% P = pcloud_read_off(filename);
% 
% %--- downsampling
% % kdtree = kdtree_build( P.points );
% % P = pcloud_downsample( P, th_downsample, kdtree );
% % kdtree_delete( kdtree );
% 
% %--- normal estimation
% kdtree = kdtree_build( P.points );
% [P.normals, P.maxCdir, P.minCdir] = pcloud_normal_estimate( P, kdtree, 'hoppe', 20 );



%--- simplejoint
% filename = 'simplejoint_old.off';
% P = pcloud_read_off(filename);
% kdtree = kdtree_build( P.points );
% P.normals = pcloud_normal_estimate( P, kdtree, 'hoppe', 20 );
% kdtree_delete( kdtree );
% pcloud_write_off(P,'simplejoint.off');


%--- U-shape
% clc, clear, close all;
% filename = 'ushape_xhires.off';
% P = pcloud_read_off(filename);
% P.points = pcloud_normalize( P );
% P = pcloud_downsample( P, .05 );
% P.normals = pcloud_normal_estimate( P, [], 'hoppe', 20 );
% pcloud_write_off(P,'ushape1.off');

%--- Woman
% clc, clear, close all;
% filename = 'woman_old.off';
% P = pcloud_read_off(filename);
% P.points = pcloud_normalize( P );
% %--- downsampling
% kdtree = kdtree_build( P.points );
% P = pcloud_downsample( P, .01, kdtree );
% kdtree_delete( kdtree );
% %--- normal estimation
% kdtree = kdtree_build( P.points );
% [P.normals, P.maxCdir, P.minCdir] = pcloud_normal_estimate( P, kdtree, 'hoppe', 20 );
% kdtree_delete( kdtree );
% pcloud_write_off(P,'woman.off');


%--- Horse
% clc, clear, close all;
% filename = 'horse.off';
% P = pcloud_read_off(filename);
% P.points = pcloud_normalize( P );
% %--- downsampling
% kdtree = kdtree_build( P.points );
% P = pcloud_downsample( P, .015, kdtree );
% kdtree_delete( kdtree );
% %--- normal estimation
% kdtree = kdtree_build( P.points );
% [P.normals, P.maxCdir, P.minCdir] = pcloud_normal_estimate( P, kdtree, 'hoppe', 20 );
% kdtree_delete( kdtree );
% pcloud_write_off(P,'horse_new.off');
% !pointlab horse_new.off