% mypoint: draws a 3D point specified by its 3D location
%
% SYNTAX
% h = mypoint( p, varargin )
%
% INPUT PARAMETERS
%   - p:        3x1 vector specifying point location
%   - varargs:  any other option you would normally give to plot3
% 
% OUTPUT PARAMETERS
%   - h: handler to created object
%
% DESCRIPTION
% this has been developed out of frustration because the matlab "plot3"
% works with a weird parameter set that makes it horrible to program
%
% Examples:
%
% draws a vertice position
% >> [h, p, hg] = meshlab( M );
% >> h = mypoint(M.vertices(1,:), 'parent', hg);
%
% See also:
% plot3
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/05/16
function h = mypoint( p, varargin )

%%% only one point
if numel(p) == 3
    h = plot3( p(1), p(2), p(3), varargin{:});

elseif numel(p) == 2
    h = plot( p(1), p(2), varargin{:});

%%% plot a set of points
elseif size(p,1) > 1 && size(p,2) == 2
    h = plot( p(:,1), p(:,2), varargin{:} );   

elseif size(p,1) > 1 && size(p,2) == 3
    h = plot3( p(:,1), p(:,2), p(:,3), varargin{:} );   

end
