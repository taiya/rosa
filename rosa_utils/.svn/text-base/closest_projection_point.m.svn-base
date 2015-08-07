% given a set of oriented lines (Pi,Vi) computes the points which
% projected distance is the absolute smallest
function P0 = closest_projection_point( P, V, TYPE, weights )

if ~exist('TYPE','var')
    TYPE='optimization';
end

if strcmp( TYPE, 'optimization_wrong')
    N = size(P,1);
    isExpanded = 0;

    % 3D Extension
    if size(P, 2) == 2
        isExpanded = 1;
        P = [ P, zeros(N,1) ];
    end
    if size(V, 2) == 2
        isExpanded = 1;
        V = [ V, zeros(N,1) ];
    end

    % x-derivative information
    a = sum( V(:,2).^2 + V(:,3).^2 );
    b = sum( V(:,1) .* V(:,2) );
    c = sum( V(:,1) .* V(:,3) );
    a0 =  sum( P(:,1) .*V(:,2).^2 + V(:,3).^2 );
    b0 = -sum( P(:,2) .*V(:,1) .* V(:,2) );
    c0 = -sum( P(:,3) .*V(:,1) .* V(:,3) );

    % y-derivative information
    d = sum( V(:,2) .* V(:,1) );
    e = sum( V(:,1).^2 + V(:,3).^2 );
    f = sum( V(:,2) .* V(:,3) );
    d0 = -sum( P(:,1) .* V(:,2) .* V(:,1) );
    e0 =  sum( P(:,2) .* V(:,1).^2 + V(:,3).^2 );
    f0 = -sum( P(:,3) .* V(:,2) .* V(:,3) );

    % z-derivative
    g = sum( V(:,3) .* V(:,1) );
    h = sum( V(:,3) .* V(:,2) );
    i = sum( V(:,1).^2 + V(:,2).^2 );
    g0 = -sum( P(:,1) .* V(:,3) .* V(:,2) );
    h0 = -sum( P(:,2) .* V(:,3) .* V(:,1) );
    i0 =  sum( P(:,3) .* V(:,1).^2 + V(:,2).^2 );

    % prepare the matrixes
    M = [ a b c; d e f; g h i ];
    B = [ a0+b0+c0; d0+e0+f0; g0+h0+i0 ];

    % check if solution is well determined
    if abs( det(M) ) < 1e-10
        P0 = [];
    else
        % compute the explicit solution
        P0 = inv(M)*B;
        disp( M )
        % remove extra dimension
        if isExpanded == 1
            P0 = P0(1:2);
        end
        P0 = P0(:);
    end
elseif strcmp( TYPE, 'optimization')
    % 3D Extension
    N = size(P,1);
    if size(P, 2) == 2
        isExpanded = 1;
        P = [ P, zeros(N,1) ];
        V = [ V, zeros(N,1) ];
    else
        isExpanded = 0;
    end
    
    Lix2 = V(:,1).^2;
    Liy2 = V(:,2).^2;
    Liz2 = V(:,3).^2;
    
    M = zeros( 3,3 );
    B = zeros( 3,1 );
    
    % Pox equations
    M(1,1) = +sum( Liy2 + Liz2 );
    M(1,2) = -sum( V(:,1).*V(:,2) );
    M(1,3) = -sum( V(:,1).*V(:,3) );
    B(1)   = sum( P(:,1).*(Liy2 + Liz2) ) -sum(V(:,1).*V(:,2).*P(:,2)) -sum(V(:,1).*V(:,3).*P(:,3));
    % Poy equations
    M(2,1) = -sum( V(:,2).*V(:,1) );
    M(2,2) = +sum( Lix2 + Liz2 );
    M(2,3) = -sum( V(:,2).*V(:,3) );
    B(2)   = sum( P(:,2).*(Lix2 + Liz2) ) -sum(V(:,2).*V(:,1).*P(:,1)) -sum(V(:,2).*V(:,3).*P(:,3));
    % Poz equations
    M(3,1) = -sum( V(:,3).*V(:,1) );
    M(3,2) = -sum( V(:,3).*V(:,2) );
    M(3,3) = +sum( Lix2 + Liy2 );
    B(3)   = sum( P(:,3).*(Lix2 + Liy2) ) -sum(V(:,3).*V(:,1).*P(:,1)) -sum(V(:,3).*V(:,2).*P(:,2));
    
    % compute solution
    if abs( det(M) ) < 1e-10
        P0 = [];
    else
        P0 = inv(M)*B;
    
        % remove extension
        if isExpanded == 1
            P0 = P0(1:2);
        end
        P0 = P0(:);
    end

elseif strcmp( TYPE, 'woptimization')
    % 3D Extension (needs to be done since we have dot products)
    N = size(P,1);
    if size(P, 2) == 2
        isExpanded = 1;
        P = [ P, zeros(N,1) ];
        V = [ V, zeros(N,1) ];
    else
        isExpanded = 0;
    end
    
    w = weights;
    
    Lix2 = V(:,1).^2;
    Liy2 = V(:,2).^2;
    Liz2 = V(:,3).^2;
    
    M = zeros( 3,3 );
    B = zeros( 3,1 );
    
    % Pox equations
    M(1,1) = +sum( w.*(Liy2 + Liz2) );
    M(1,2) = -sum( w.*V(:,1).*V(:,2) );
    M(1,3) = -sum( w.*V(:,1).*V(:,3) );
    B(1)   = sum( w.*P(:,1).*(Liy2 + Liz2) ) -sum(w.*V(:,1).*V(:,2).*P(:,2)) -sum(w.*V(:,1).*V(:,3).*P(:,3));
    % Poy equations
    M(2,1) = -sum( w.*V(:,2).*V(:,1) );
    M(2,2) = +sum( w.*(Lix2 + Liz2) );
    M(2,3) = -sum( w.*V(:,2).*V(:,3) );
    B(2)   = sum( w.*P(:,2).*(Lix2 + Liz2) ) -sum(w.*V(:,2).*V(:,1).*P(:,1)) -sum(w.*V(:,2).*V(:,3).*P(:,3));
    % Poz equations
    M(3,1) = -sum( w.*V(:,3).*V(:,1) );
    M(3,2) = -sum( w.*V(:,3).*V(:,2) );
    M(3,3) = +sum( w.*(Lix2 + Liy2) );
    B(3)   = sum( w.*P(:,3).*(Lix2 + Liy2) ) -sum(w.*V(:,3).*V(:,1).*P(:,1)) -sum(w.*V(:,3).*V(:,2).*P(:,2));
    
    % compute solution
    if abs( det(M) ) < 1e-10
        P0 = [];
    else
        P0 = inv(M)*B;
    
        % remove extension
        if isExpanded == 1
            P0 = P0(1:2);
        end
        P0 = P0(:);
    end
else
    % average of every pair of intersections
    centroids = zeros(size(P,1)^2,2);
    counter = 1;
    for i=1:size(P,1)
        for j=i+1:size(P,1)
            A = P(j,:);
            B = P(j,:) + V(j,:);
            t1 = line_segment_intersection( P(i,:), V(i,:), A, B );
            centroids(counter,:) = A+(B-A)*t1;
            counter = counter + 1;
        end
    end
    P0 = mean( centroids,1 );
end
