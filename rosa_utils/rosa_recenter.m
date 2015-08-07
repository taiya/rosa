function [P,SK] = rosa_recenter( P, alpha )

VIEW_RESULTS = true;

%--- view the extracted graph before recentering
if VIEW_RESULTS
    close all
    figure(1), movegui('northeast');
    hg = getappdata( pcloud_view(P), 'hg' );
    hpts = mypoint3( P.skelver, '.r', 'parent', hg );
    heds = [];
    for i=1:size(P.skel_adj,1)
       for j=1:size(P.skel_adj,2)
            if( P.skel_adj(i,j)==1 )
                heds(end+1) = myedge3(P.skelver(i,:), P.skelver(j,:), 'parent', hg); %#ok<AGROW>
            end
       end
    end
end

% alpha balances between euclidean and projected neighborhood
deleted_vertice_idxs = [];
for i=1:length(P.skelver)
    idxs = find( P.corresp==i );
    if length(idxs)<3 
        deleted_vertice_idxs(end+1) = i;
    else
        proj_center = closest_projection_point( P.points(idxs,:), P.normals(idxs,:),'optimization')';
        eucl_center = mean( P.points(idxs,:),1 );
        P.skelver(i,:) = alpha*proj_center + (1-alpha)*eucl_center;
    end
end
P.skelver(deleted_vertice_idxs,:) = [];
P.skel_adj(deleted_vertice_idxs,:) = [];
P.skel_adj(:,deleted_vertice_idxs) = [];

%--- view the extracted graph after recentering
if VIEW_RESULTS
    figure(2), movegui('southeast');
    hg = getappdata( pcloud_view(P), 'hg' );
    hpts = mypoint3( P.skelver, '.r', 'parent', hg );
    heds = [];
    for i=1:size(P.skel_adj,1)
       for j=1:size(P.skel_adj,2)
            if( P.skel_adj(i,j)==1 )
                heds(end+1) = myedge3(P.skelver(i,:), P.skelver(j,:), 'parent', hg);
            end
       end
    end
end

%--- save the graph to a curvegraph format
SK.vertices = P.skelver;
SK.edges = zeros(0,2);
for i=1:size(P.skel_adj,1)
   for j=i+1:size(P.skel_adj,2)
        if( P.skel_adj(i,j)==1 )
            SK.edges(end+1,:) = [i,j];
        end
   end
end