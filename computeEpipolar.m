function [left,right] = computeEpipolar(F)
%To compute left and right epipoles, recall that they are respectively, 
% the right and left null space of F, thus you can simply 
% perform the SVD decomposition of F, F=UWVT,  
[U, W, V] = svd(F);

% and then select the last columns of U and V.

left = U(:, end);
right = V(:, end); 

% Normalize to ensure homogeneous coordinates
left = left / left(end);
right = right / right(end);
end