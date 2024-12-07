function [F] = EightPointsAlgorithm(P1, P2)
    
% Write down the matrix A
for i = 1:size(P1, 1)
    x1 = P1(i, 1); y1 = P1(i, 2);
    x2 = P2(i, 1); y2 = P2(i, 2);
    A(i, :) = [x2*x1, x2*y1, x2, y2*x1, y2*y1, y2, x1, y1, 1]; 
end
% Compute the SVD decomposition of A → [U, D, V]=svd(A);
[U, D, V]=svd(A);

% and select as solution f the last column of V.
f = V(:, end);
% Reshape the column vector f so to obtain a matrix F (see function reshape)
F = reshape(f, [3, 3])';

% Force the rank of F to be 2:
% Use again the SVD to decompose the matrix [U, D, V] = svd(F)
[U, D, V] = svd(F);
D(3,3)=0;
F = U * D * V';
end