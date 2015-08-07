% mypoint3: draws a 3D point specified by its 3D location
%
% SYNTAX
% h = mypoint3( p, varargin )
%
% INPUT PARAMETERS
%   - p: 3x1 vector specifying point location
%   - varargs:  any other option you would normally give to plot3
% 
% OUTPUT PARAMETERS
%   - h: handler to created graphic object
%
% DESCRIPTION
% This is a utility function that allows to avoid to give 
% the three coordinates to the Matlab plot3() built in.
% Instead we just give a Nx3 matrix, with one 3D point for 
% each row.
%
% EXAMPLE
% draws the position of the first vertice
% >> M = mesh_read_smf('rabbit.smf');
% >> M.vertices = mesh_normalize(M);
% >> h = mesh_view( M );
% >> hg = getappdata( h, 'hg' );
% >> mypoint3( M.vertices(1,:), '.r', 'parent', hg );
%
% SEE ALSO:
% PLOT3, MESH_VIEW
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  16 May. 2008: created by Andrea Tagliasacchi
% $Revision: 1.2$   3 Mar. 2009: refactored content

function h = mypoint3( p, varargin )
    h = plot3( p(:,1), p(:,2), p(:,3), varargin{:} );   