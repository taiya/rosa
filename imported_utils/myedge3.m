% nyedge: draws a 3D edge specified by two 3D points
%
% SYNTAX
% h = nyedge( p1, p2, ... )
%
% OUTPUT PARAMETERS
%   h: handler to created object
%
% DESCRIPTION
% this has been developed out of frustration because the matlab "line"
% works with a weird parameter set that makes it horrible to program
%
% See also:
% LINE

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/05/28
function h = myedge3( A, B, varargin )
    h = line( [A(1), B(1)], [A(2), B(2)], [A(3), B(3)], varargin{:} );
end %end of myline
