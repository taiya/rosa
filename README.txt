%-----------------------------      SETTING UP         ------------------------------%
1) The KDTree library needs to be compiled (http://www.mathworks.com/matlabcentral/fileexchange/21512)
2) The KDTree library need to be included in the path (use "pathtool")
3) The rosa folder "rosa_utils" must be included in the path
4) compile the MEX file in rosa_utils: ">> mex pcloud_isoncut.cpp" (requires MEX environment setup)

%-----------------------------      HOW TO USE         ------------------------------%
The core of the program is "rosa_main.m". The second line of the program specifies which point cloud 
should be processed (filename = 'simplejoint'). This will cause the program to read the point cloud 
"simplejoint.off" and the options file "simplejoint.m". 

The input file needs to be in a special "off" format which contains normals. Below is an excerpt:
>>	NOFF
>>	2166 0
>>	-0.485766 0.252970 -0.932399 0.929435 0.368951 0.004973
>>	-0.484826 0.253969 -0.877092 0.917905 0.395731 -0.029131
NOFF Specifies the format, off file with Normals. 2166 is the number of samples.
0 as there is no triangles in this object file. Each line is then composed by 
6 floats. The first three represent the vertex coordinate. The latter three, 
the pre-computed vertex normal. 

The computation of the skeleton is broken in several stages. Each stage can be run as a MATLAB "Cell" if 
you enable the "cell mode" of its environment. Each stage outputs a ".mat" file that can be easily
loaded for inspection.

The output of the algorithm is in CurveGraph (cg) format
>>	# D:3 NV:22 NE:21
>>	v -0.693442 -0.004470 -0.744194
>>	v -0.854085 -0.744194 0.006110
>>	.....
>>	e 2 3
>>	e 3 4
>>	.....
This graph has an embedding in R^3 (as mentioned in D:3), It has Nv:22 vertices
and Ne:21 edges. Each vertice coordinate is prefixed by "v", each edge by "e".
Edges specify an undirected connection between two vertices. "e 2 3" means that 
the 2nd and 3rd vertices are connected by an edge. Vertices are 1-indexed as 
commonly done in matlab.  

%---------------------------- OPTION FILE DESCRIPTION -----------------------------%
>> radius_mah: [scale depends from shape], th_mah: [0,1]
radius of the mahalanobis neighborhood. The larger the radius, the larger the 
size of the local candidate neighborhood of a surface sample. These candidates
are then pruned by th_mah. A 0 value of th_mah accepts all mahalanobis neighbors
as true neighbors. The small script "test_clustering.m" can be used to test out 
parameter settings for the mahalanobis neighborhood. 

>> numiter_drosa [~10], numiter_dcrosa [~20]; 
drosa iterations are the one that update the symmetry directions
in an iterative fashion. No more than 10 iterations are usually necessary.
In the latter version, symmetry directions are smoothed after every update. 

>> delta
This specifies the "cut" thickness.  

>> k_kNN
Connectivity to be pruned by the line-extraction. We assume a surface neighborhood
of k_kNN samples in the skeletal cloud. This pseudo-connectivity is then pruned down
in order to extract a line representation. We aim to remove all the "triangles" from 
this graph which connect 

>> sample_radius 
Subsample the skeletal cloud and extracts a sparse skeletal representation.
Subsamples inherit the connectivity from the surface samples and then this 
connectivity matrix is collapsed so that the graph is locally 1D.
This is similar to Au's solution and to the edge collapse skeleton solution.

>> alpha_recenter
Graph embedding. Each skeletal sample has a set of corresponding surface points.
How to embed the graph using that information? This parameter decides on a linear
interpolation between euclidean and projected centroid.

