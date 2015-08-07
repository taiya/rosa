% COMPUTE_SYMMETRYNORMAL short description
%
% SYNTAX
% [output] = compute_symmetrynormal(V)
%
% INPUT PARAMETERS
%   V: a [Nx3] matrix containing a 3D vector on each row.
%
% OUTPUT PARAMETERS
%   output: the symmetrynormal vector direction
%
% DESCRIPTION
% The symmetrynormal is defined as the curve such that 
% the angle between the optimal vector and all the other 
% ones is as similar as possible, that is, its variance 
% is minimized.
% 
%
% Examples:
% EXAMPLE_SYMMETRYNORMAL
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/09/08
function [vsymm, vsymm2,vsymm3] = compute_symmetrynormal(V,w, alpha)
% regularization term.
% set to 0  to exclude
% set to 10 for xpartial good results
% set to 50 ??
alpha = 0; 
if true %~exist( 'w','var' )
    % construct the quadratic form matrix
    N = size( V, 1 );
    Vxx = (1+alpha)*sum(V(:,1).^2)/N - sum(V(:,1))^2/N^2; 
    Vyy = (1+alpha)*sum(V(:,2).^2)/N - sum(V(:,2))^2/N^2;
    Vzz = (1+alpha)*sum(V(:,3).^2)/N - sum(V(:,3))^2/N^2;
    Vxy = 2*(1+alpha)/N*sum(V(:,1).*V(:,2)) - 2/N^2*sum(V(:,1))*sum(V(:,2)); Vyx = Vxy;
    Vxz = 2*(1+alpha)/N*sum(V(:,1).*V(:,3)) - 2/N^2*sum(V(:,1))*sum(V(:,3)); Vzx = Vxz;
    Vyz = 2*(1+alpha)/N*sum(V(:,2).*V(:,3)) - 2/N^2*sum(V(:,2))*sum(V(:,3)); Vzy = Vyz;
    M = [ Vxx Vxy Vxz; Vyx Vyy Vyz; Vzx Vzy Vzz ];
    [vec, lam] = svd( M );
else
    % construct the quadratic form matrix
    N = sum(w);
    w = w(:);
    
    %%% THIS WAS INCORRECT!! 
	% Vxx = sum(V(:,1).^2.*w)/N - sum(V(:,1).*w)^2/N^2; 
	% Vyy = sum(V(:,2).^2.*w)/N - sum(V(:,2).*w)^2/N^2;
	% Vzz = sum(V(:,3).^2.*w)/N - sum(V(:,3).*w)^2/N^2;
	% Vxy = 2/N*sum(V(:,1).*V(:,2).*w.*w) - 2/N^2*sum(V(:,1).*w)*sum(V(:,2).*w); Vyx = Vxy;
	% Vxz = 2/N*sum(V(:,1).*V(:,3).*w.*w) - 2/N^2*sum(V(:,1).*w)*sum(V(:,3).*w); Vzx = Vxz;
	% Vyz = 2/N*sum(V(:,2).*V(:,3).*w.*w) - 2/N^2*sum(V(:,2).*w)*sum(V(:,3).*w); Vzy = Vyz;
	% M = [ Vxx Vxy Vxz; Vyx Vyy Vyz; Vzx Vzy Vzz ];
	% [vec, lam] = svd( M );
    
    % THIS IS CORRECT
%     Vxx = sum(V(:,1).^2.*w)/N - sum(V(:,1).*w)^2/N^2; 
%     Vyy = sum(V(:,2).^2.*w)/N - sum(V(:,2).*w)^2/N^2;
%     Vzz = sum(V(:,3).^2.*w)/N - sum(V(:,3).*w)^2/N^2;
%     Vxy = 2/N*sum(V(:,1).*V(:,2).*w) - 2/N^2*sum(V(:,1).*w)*sum(V(:,2).*w); Vyx = Vxy;
%     Vxz = 2/N*sum(V(:,1).*V(:,3).*w) - 2/N^2*sum(V(:,1).*w)*sum(V(:,3).*w); Vzx = Vxz;
%     Vyz = 2/N*sum(V(:,2).*V(:,3).*w) - 2/N^2*sum(V(:,2).*w)*sum(V(:,3).*w); Vzy = Vyz;
%     M = [ Vxx Vxy Vxz; Vyx Vyy Vyz; Vzx Vzy Vzz ];
%     [vec, lam] = svd( M );
end
% disp( lam )

% extract eigenvector of smallest eigenvalue
[IGN, IDX] = min( [lam(1,1), lam(2,2), lam(3,3) ] );
vsymm = vec(:,IDX);
vsymm2 = vec(:,2); % DEBUG!!!
vsymm3 = vec(:,1);

end %end of compute_vectors_isonormal
