% PCLOUD_WRITE_OFF writes a point cloud from an object file
%
% SYNOPSIS
% function P = pcloud_write_off(filename)
%
% INPUT PARAMETERS
%   - filename: path to the target OFF file
%
% OUTPUT PARAMETERS
%   - P: a point cloud in pcloud format
%
% DESCRIPTION
%
% Examples:
% >> P.points = rand(1000,3);
% >> P = pcloud_read_off('random.off');
%
% See also:
% PCLOUD_WRITE_OFF
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Dec.11,2008 11:54:25: created
function P = pcloud_write_off(P,filename)

if isfield(P,'skele') && isfield(P,'color')
    % open the file
    fid = fopen(filename,'w');
    if fid == -1
        error(['ERROR: could not open file "' filename '"']);
    end
    % write header
    fprintf(fid, 'NOFF_SK_COL\n');
    fprintf(fid, '%d 0\n', length(P.points) );
    
    % write the points/normals
    for i=1:size(P.points,1)
        fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f %f\n', P.points(i,:), P.normals(i,:), P.skele(i,:), P.color(i,:) );
    end
    
elseif isfield(P,'skele')
    if size(P.points, 2) ~= 3 || size(P.normals, 2) ~= 3 || size(P.skele, 2) ~= 3
       error('the points and normals matrixes should have at least 3 columns');
    end
    % open the file
    fid = fopen(filename,'w');
    if fid == -1
        error(['ERROR: could not open file "' filename '"']);
    end
    % write header
    fprintf(fid, 'NOFF_SK\n');
    fprintf(fid, '%d 0\n', length(P.points) );
    
    % write the points/normals
    for i=1:size(P.points,1)
        fprintf(fid, '%f %f %f %f %f %f %f %f %f\n', P.points(i,:), P.normals(i,:), P.skele(i,:) );
    end
elseif isfield(P,'color')
    if size(P.points, 2) ~= 3 || size(P.normals, 2) ~= 3 || size(P.color, 2) ~= 3
       error('the points and normals matrixes should have at least 3 columns');
    end
    % open the file
    fid = fopen(filename,'w');
    if fid == -1
        error(['ERROR: could not open file "' filename '"']);
    end
    % write header
    fprintf(fid, 'NOFF_COL\n');
    fprintf(fid, '%d 0\n', length(P.points) );
    
    % write the points/normals/skel/color
    for i=1:size(P.points,1)
        fprintf(fid, '%f %f %f %f %f %f %f %f %f\n', P.points(i,:), P.normals(i,:), P.color(i,:) );
    end
    
elseif isfield(P,'normals')
    if size(P.points, 2) ~= 3 || size(P.normals, 2) ~= 3
       error('the points and normals matrixes should have at least 3 columns');
    end
    % open the file
    fid = fopen(filename,'w');
    if fid == -1
        error(['ERROR: could not open file "' filename '"']);
    end
    % write header
    fprintf(fid, 'NOFF\n');
    fprintf(fid, '%d 0\n', length(P.points) );
    
    % write the points/normals
    for i=1:size(P.points,1)
        fprintf(fid, '%f %f %f %f %f %f\n', P.points(i,:), P.normals(i,:) );
    end
else
    if size(P.points, 2) ~= 3
       error('the points matrix should have at least 3 columns');
    end
    % open the file
    fid = fopen(filename,'w');
    if fid == -1
        error(['ERROR: could not open file "' filename '"']);
    end
    % write header
    fprintf(fid, 'OFF\n');
    fprintf(fid, '%d 0\n', length(P.points) );
    
    % write the points/normals
    for i=1:size(P.points,1)
        fprintf(fid, '%f %f %f\n', P.points(i,:) );
    end
end
disp( sprintf('pcloud file written in OFF/OBJ file: %s\n', filename) );

% Close file
fclose(fid);