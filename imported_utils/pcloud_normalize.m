function points = pcloud_normalize( P )

% re-center
MN = mean(P.points);
P.points(:,1) = P.points(:,1) - MN(1);
P.points(:,2) = P.points(:,2) - MN(2);
P.points(:,3) = P.points(:,3) - MN(3);


% scale
mn = min( P.points );
mx = max( P.points  );
range = max(mx - mn);
half_range = range/2;
cnst = (mx - mn)/2;
points(:,1) = (P.points(:,1) -mn(1) -cnst(1)) / half_range;
points(:,2) = (P.points(:,2) -mn(2) -cnst(2)) / half_range;
points(:,3) = (P.points(:,3) -mn(3) -cnst(3)) / half_range;

% 
% % Compile vertex list, changing model coordinates (mapping to -1.0, 1.0)
% for i = 1:size(P.points, 1)
% 	P_new(i, :) = (P.points(i, :) - mn - cnst)/half_range;
% end
% 
% close(h_wait);
