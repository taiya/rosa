% PCLOUD_READ_OFF reads a point cloud from an object file
%
% SYNOPSIS
% function P = mesh_read_ply(filename)
%
% INPUT PARAMETERS
%   - filename: path of the OFF file
%
% OUTPUT PARAMETERS
%   - P: a point cloud in pcloud format
%
% DESCRIPTION
% this is based on the "trilab" implementations
% include the package in your path to be able to use it
%
% Examples:
% description of example for pcloud_read_off
% >> P = pcloud_read_off('wooddoll.ply');
%
% See also:
% MESH_READ_OFF(TRILAB), PCLOUD_READ_PLY
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/09/26
function P = pcloud_read_off(filename)

% Open file
fid = fopen(filename);
if fid == -1
    error(['ERROR: could not open file "' filename '"']);
end

% Read content
SIZ = [];
% parsing flags
READOFF         = true;
READHEADER      = false;
READDATA        = false;
NEEDREADNORMALS = false;
NEEDREADSKEL    = false;
NEEDREADCOLOR   = false;

datanum = 1;
LINECOUNTER = 0;
h = txtwaitbar('init', 'reading OBJ file: ');
while(feof(fid) ~= 1)
    line = fgetl(fid);

    % skip blank line
    if isempty(line)
        continue;
    end

    if READOFF == true && ( strcmp(line,'OFF') || strcmp(line,'NOFF') || strcmp(line,'NOFF_SK') || strcmp(line,'NOFF_COL'))
        READHEADER = true;
        READOFF = false;
        if strcmp(line,'NOFF')
            NEEDREADNORMALS = true;
        end
        if strcmp(line,'NOFF_SK')
            NEEDREADSKEL = true;
        end
        if strcmp(line,'NOFF_COL')
            NEEDREADCOLOR = true;
        end
        

    elseif READHEADER == true
        SIZ = sscanf(line, '%d %d');
        % make data
        points = zeros( SIZ(1), 3 );
        if NEEDREADNORMALS
            normals = zeros( SIZ(1), 3 );
        end
        if NEEDREADNORMALS
            skel = zeros( SIZ(1), 3 );
        end
        if NEEDREADCOLOR 
            color = zeros( SIZ(1), 3 );
        end
        READHEADER = false;
        READDATA = true;

    elseif READDATA == true && datanum <= SIZ(1)
        if NEEDREADSKEL
            data = sscanf(line, '%f %f %f %f %f %f %f %f %f');  
            points(datanum, :)  = data(1:3);
            normals(datanum, :) = data(4:6);
            skel(datanum,:)     = data(7:9);
        elseif NEEDREADNORMALS
            data = sscanf(line, '%f %f %f %f %f %f');  
            points(datanum, :)  = data(1:3);
            normals(datanum, :) = data(4:6);
        elseif NEEDREADCOLOR
            data = sscanf(line, '%f %f %f %f %f %f %f %f %f');  
            points(datanum, :)  = data(1:3);
            normals(datanum, :) = data(4:6);            
            color(datanum, :) = data(7:9);
        else
            points(datanum, :)  = sscanf(line, '%f %f %f');  
        end

        if datanum > SIZ(1), error('read more lines than declared in the header'); end
        datanum = datanum + 1;
    end
	
    % update progress bar
    if READDATA
        h = txtwaitbar(LINECOUNTER/(sum(SIZ)), h);
        LINECOUNTER = LINECOUNTER + 1;
    end
end
txtwaitbar('close', h);

% Close file
fclose(fid);

% Set up output mesh
P = struct();
P.points = points;
if NEEDREADNORMALS
    P.normals = normals;
end
if NEEDREADSKEL
    P.normals = normals;
    P.skel    = skel;
end
        