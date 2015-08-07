% MAHALANOBIS DISTANCE as in lehtinen 2008
% all vectors are assumed to be "horizontal"
% 
% w = 0 --> points far from each other
% w = 1 --> points close to each other
function w = mahalanobis_leth(p1, v1, p2, v2, Radius, Fs )

% default argument
Fs = 2;

% Mahalanobius Distance
dist = norm( p1-p2 + Fs*((p1-p2)*v1')*v1 );

% Smooth kernel function is one for dist=0
% decays slowly to 0 as approaching dist=1
k = 0;
dist = dist / Radius;
if dist<=1, k=2*dist^3-3*dist^2+1; end

% penalize vectors which are backpointing
% use dot product weight otherwise
w = k * max( 0, v1*v2' )^2;