% smooth undirected vectors v, with weights w
function vopt = symmnormal_smooth( V, w )

% Solution of the following equation which smooths a set of "undirected" vectors V
% 
% V = \underset{V}{argmax} \sum_{i} w_i \langle V, v_i \rangle ^2
%  
Vxx = sum( w.*V(:,1).^2 ); 
Vyy = sum( w.*V(:,2).^2 );
Vzz = sum( w.*V(:,3).^2 );
Vxy = sum( w.*V(:,1).*V(:,2) );
Vxz = sum( w.*V(:,1).*V(:,3) );
Vyx = Vxy;
Vyz = sum( w.*V(:,2).*V(:,3) );
Vzx = Vxz;
Vzy = Vyz; 

M = [ Vxx Vxy Vxz; Vyx Vyy Vyz; Vzx Vzy Vzz ];
[vec, lam] = svd( M, 'econ' );
vopt = vec(:,1);

