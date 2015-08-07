function P = rosa_lineextract(P, pset, RADIUS, k_kNN)

    
% visual debug conditions
SHOW_RESULTS = true;
SHOW_SAMPLING_PROGRESS = false;
SHOW_EDGECOLLAPSE_PROGRESS = true;


if SHOW_SAMPLING_PROGRESS == true || SHOW_RESULTS == true
    close all;
    figure(1); movegui('northeast');
    hg = getappdata( pcloud_view(P), 'hg' );
    mypoint3(pset, '.r', 'markersize', 1, 'parent', hg);
end

%--- mark badly neighbored samples (their pset/vset might is erroneous)
bad_sample = zeros( length(P.points),1 );
for i=1:length(P.points)
    if length(P.neighs{i})==1
        bad_sample(i) = 1;
    end
end

%--- FURTHEST POINT DOWNSAMPLE THE CLOUD
% use balls of size RADIUS to downsample the point cloud in a furthest sample fashion
kdtree = kdtree_build( pset );
P.skelver = zeros( 0, 3 );
mindst = nan( length(pset), 1 );
P.corresp = zeros( length(pset), 1 );
for k=1:length(pset)
    if P.corresp(k)~=0, continue, end;
        
    %--- query all the points for distances
    mindst(k) = inf; % make sure picked first
    
    %--- initialize the priority queue
    while ~all(P.corresp~=0)
        maxIdx = max_idx( mindst );
        if mindst(maxIdx) == 0, break, end;    

        % query its delta-neighborhood
        [nIdxs, nDsts] = kdtree_ball_query( kdtree, pset(maxIdx,:), RADIUS );

        % if its neighborhood has been marked already, skip ahead
        if all( P.corresp(nIdxs) ~= 0 ), mindst(maxIdx) = 0; continue, end;

        % create new node and update (closest) distances
        P.skelver(end+1,:) = pset(maxIdx,:); %#ok<AGROW>
        for i=1:length(nIdxs)
            if mindst(nIdxs(i))>nDsts(i) || isnan(mindst(nIdxs(i)))
               mindst(nIdxs(i)) = nDsts(i);
               P.corresp(nIdxs(i)) = size(P.skelver,1);
            end
        end

        if SHOW_SAMPLING_PROGRESS == true
            figure(1); mypoint3( pset(maxIdx,:), '*g', 'parent', hg );movegui('east');
            figure(2); myscatter3( pset, 5, mindst, 'filled');view(+88,0); movegui('southeast');
        end
    end
end

%--- COMPRESS MAHALANOBIS NEIGHBORHOOD MATRIX
% Neighbors of P.skelver is inherited from the skeletal samples to which they correspond
A = zeros( length(P.skelver), length(P.skelver) );
surf_kdtree = kdtree_build( P.points );
for pIdx=1:length(pset)
    
    % skip badly conditioned points (projected to weird places as they have very few neighbors)
    if length(P.neighs{pIdx})==1, continue; end
       
    %--- use k-nn, better
    neighs = kdtree_k_nearest_neighbors( surf_kdtree, P.points(pIdx,:), k_kNN);
    % filter out bad samples again....
    neighs = neighs( bad_sample(neighs)==0 );
    
    if P.corresp(pIdx) == 0, continue, end;
    for nIdx=1:length(neighs)
        if P.corresp(neighs(nIdx)) == 0, continue, end;
        A( P.corresp(pIdx), P.corresp(neighs(nIdx)) ) = 1;
        A( P.corresp(neighs(nIdx)), P.corresp(pIdx) ) = 1;
    end
end
kdtree_delete( surf_kdtree );

%--- EDGE COLLAPSE 
% collapse the adjecency matrix A until the described graph is 1-dimensional
% this inherits some ideas from the Skeleton by Contraction paper.
while true
    %DEBUG: display connectivity and vertexes at every iteration
    if SHOW_EDGECOLLAPSE_PROGRESS
        hpts = mypoint3( P.skelver, '.r', 'parent', hg );
        heds = [];
        for i=1:size(A,1)
            for j=1:size(A,2)
                if( A(i,j)==1 )
                    heds(end+1) = myedge3(P.skelver(i,:), P.skelver(j,:), 'parent', hg); %#ok<AGROW>
                end
            end
        end
        delete(hpts);
        delete(heds);
    end

    %--- RECOVER CONNECTIVITY
    % TODO: iterative update, HUGE SPEEDUP!
    % recover the set of edges on triangles & count triangles
    tricount = 0;
    skeds = zeros(0,2);
    skcst = zeros(0,1);
    for i=1:length(P.skelver)
        neighs = sort( find(A(i,:)==1) );
        neighs = neighs( neighs>i );
        for j=1:length(neighs)
            for k=j+1:length(neighs)
                if A(neighs(j),neighs(k)) == 1,
                    tricount = tricount+1;
                    skeds(end+1,:) = [i,neighs(j)];                                                        %#ok<AGROW>
                    skcst(end+1,:) = euclidean_distance( P.skelver(i,:), P.skelver(neighs(j),:) );         %#ok<AGROW>
                    skeds(end+1,:) = [neighs(j),neighs(k)];                                                %#ok<AGROW>
                    skcst(end+1,:) = euclidean_distance( P.skelver(neighs(j),:), P.skelver(neighs(k),:) ); %#ok<AGROW>
                    skeds(end+1,:) = [neighs(k),i];                                                        %#ok<AGROW>
                    skcst(end+1,:) = euclidean_distance( P.skelver(neighs(k),:), P.skelver(i,:) );         %#ok<AGROW>
                    % disp( skeds(end-2:end,:) );
                end
            end
        end
    end
    
    disp(sprintf('decimating skeletal graph, remaining #%d loops:', tricount));
    
    %--- STOP CONDITION
    % no more triangles? then the structure is 1D
    if tricount == 0, break, end;
    
    %--- DECIMATION STEP + UPDATES
    % collapse the edge with minimum cost, remove the second vertex
    [IGN, idx] = min( skcst );
    edge = skeds(idx,:);
    % update the location
    P.skelver( edge(1),: ) = mean( P.skelver( edge,: ) ); %#ok<AGROW>
    P.skelver( edge(2),: ) = NaN; %#ok<AGROW>
    % update the A matrix
    for k=1:size(A,1)
        if A(edge(2),k) == 1, 
            A(edge(1),k)=1; 
            A(k,edge(1))=1; 
        end
    end
    % remove the row
    A(edge(2),:) = 0;
    A(:,edge(2)) = 0;
    % update the correspondents
    P.corresp( P.corresp==edge(2) ) = edge(1); %#ok<AGROW>
end

% save the skeleton adjecency matrix
P.skel_adj = A;


% display extracted structure
if SHOW_RESULTS
    figure(2); movegui('southeast');
    hg = getappdata( pcloud_view(P), 'hg' );
    mypoint3( P.skelver, '.r', 'parent', hg );
    for i=1:size(A,1)
        for j=1:size(A,2)
            if( A(i,j)==1 )
                myedge3(P.skelver(i,:), P.skelver(j,:), 'parent', hg); %#ok<AGROW>
            end
        end
    end
end