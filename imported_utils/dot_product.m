% DOT_PRODUCT vector/matrix dot product 
%
% SYNTAX
% 1) d = dot_product(v1, v2) % vector vector
% 2) d = dot_product(v1, m1) % vector matrix
% 3) d = dot_product(m1, v1) % matrix vector
% 4) d = dot_product(v1, v2) % matrix matrix
%
% INPUT PARAMETERS
%   m: a matrix of vectors [Nx3] (or [Nx2])
%   v: a vector of size    [1x3] (or [1x2])
%
% OUTPUT PARAMETERS
%   d: the resulting dot product 
%       1)   the dot product of the two vectors
%       2,3) d(i): the dot product of the vector i-th row of the matrix
%       4)   d(i): the dot product of the i-th rows of the two matrixes
%
% DESCRIPTION
% general dot product between vector or matrixes in 2D/3D
% 
% See also:
% DOT, DOT_PRODUCT_DEMO
%

% Copyright (c) 2008 Andrea Tagliasacchi
% All Rights Reserved
% email: ata2@cs.sfu.ca 
% $Revision: 1.0$  Created on: 2008/09/26
function D = dot_product( v1, v2 )
    % NOTE: keep most often done first
    
    % simple 3D vectors
    if numel( v1 ) == 3 && numel( v2 ) == 3
        D = v1(1)*v2(1) + v1(2)*v2(2) + v1(3)*v2(3);
    % simple 2D vectors
    elseif numel( v1 ) == 2 && numel( v2 ) == 2
        D = v1(1)*v2(1) + v1(2)*v2(2);
    
    % 3D vector - 3D matrix (and opposite)
    elseif numel( v1 ) == 3 && size( v2, 1 ) > 1 && size( v2, 2 ) == 3
        D = vec_mat_3D( v1, v2 );
    elseif numel( v2 ) == 3 && size( v1, 1 ) > 1 && size( v1, 2 ) == 3
        D = vec_mat_3D( v2, v1 );
                
    % 2D vector - 2D matrix (and opposite)
    elseif numel( v1 ) == 2 && size( v2, 1 ) > 1 && size( v2, 2 ) == 2
        D = vec_mat_2D( v1, v2 );
    elseif numel( v2 ) == 2 && size( v1, 1 ) > 1 && size( v1, 2 ) == 2
        D = vec_mat_2D( v2, v1 );
    
    % 3D matrix - 3D matrix
    elseif size( v1, 1 ) > 1 && size( v1, 2 ) == 3 && size( v2, 1 ) > 1 && size( v2, 2 ) == 3
        D = mat_mat_3D( v1, v2 );
    
    % 2D matrix - 2D matrix
    elseif size( v1, 1 ) > 1 && size( v1, 2 ) == 2 && size( v2, 1 ) > 1 && size( v2, 2 ) == 2
        D = mat_mat_2D( v1, v2 );
    
    % error
    else
        error('The input arguments are incorrect');
    end
    
        
function D = vec_mat_2D( v, m )
    D = zeros( size(m,1), 1 );
    for i=1:size(m,1)
       D(i) = m(i,1)*v(1) + m(i,2)*v(2); 
    end
end

function D = vec_mat_3D( v, m )
    D = zeros( size(m,1), 1 );
    for i=1:size(m,1)
       D(i) = m(i,1)*v(1) + m(i,2)*v(2) + m(i,3)*v(3); 
    end
end

function D = mat_mat_3D( m1, m2 )
    D = zeros( size(m1,1), 1 );
    for i=1:size(m1,1)
       D(i) = m1(i,1)*m2(i,1) + m1(i,2)*m2(i,2) + m1(i,3)*m2(i,3); 
    end
end

function D = mat_mat_2D( m1, m2 )
    D = zeros( size(m1,1), 1 );
    for i=1:size(m1,1)
       D(i) = m1(i,1)*m2(i,1) + m1(i,2)*m2(i,2); 
    end
end

end %end of dot_product
