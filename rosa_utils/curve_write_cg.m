function curve_write_cg( C, curve_filename )

if size(C.vertices,2) ~= 3
    error('curve_write_cg has been implemented only for R^3');
end

fid = fopen(curve_filename, 'w');
fprintf(fid, '# D:%d NV:%d NE:%d\n', size(C.vertices,2), size(C.vertices,1), size(C.edges,1) );
for i=1:length(C.vertices)
    fprintf(fid,'v %f %f %f\n', C.vertices(i,:));
end
for i=1:length(C.edges)
    fprintf(fid,'e %d %d\n', C.edges(i,:));
end