% CREATE_ORTHONORMAL_FRAME starting from a vector V and seed S
% creates an orthonormal frame M
%
% SYNTAX
% M = create_orthonormal_frame(V)
%
% INPUT PARAMETERS
%   V: a k-dimensional norm-1 vector 
%
% OUTPUT PARAMETERS
%   M: a [KxK] orthonormal matrix which span R^K where
%      the first row is the vector V itself
%
% DESCRIPTION
% This is based on QR factorization where a normalized random vector 
% is generated, its contributions to m dimensions (if m vectors are 
% already computed in the result) are processed and removed to span 
% the remaining 
% space.
% 
% Examples:
% description of example for create_orthonormal_frame
% >> M = create_orthonormal_frame( [1,0,0], 1 );
% >> myline( zeros(3), M ); axis equal; view(3);
%
% See also:
% PROJECT_ON_PLANE
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/09/29
function M = create_orthonormal_frame( V, randseed )

global TH_ZERO;
if isempty(TH_ZERO), TH_ZERO = 1e-10; end;

prevstate = [];
if exist('randseed', 'var')
    prevstate = rand('twister');
    rand('twister', randseed);
end

% standard V format
V = V(:);
K = size( V, 1 );

%%% generate vectors not-parallel to Np
M = zeros( size(V,1), size(V,1) );
M( 1,: ) = V; 

for i=2:K

    % create new non-parallel vector
    new_vec = randn(K,1); % random
    new_vec = new_vec/norm(new_vec);
    while (1-V'*new_vec) < TH_ZERO
        new_vec = rand(K,1); % random K-dimension vector 
        new_vec = new_vec/norm(new_vec); % normalize it
    end
     
    % removed the contributions of spaces spanned by the 
    % previous vectors
    for j=1:i-1
        new_vec = vector_normalize( new_vec - dot_product( new_vec, M(j,:) )*M(j,:)' ); 
    end
    
    % add vector to the matrix
    M(i,:) = new_vec;
end

if ~isempty(prevstate)
    rand('twister', prevstate);
end