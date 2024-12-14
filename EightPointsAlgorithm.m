function [F] = EightPointsAlgorithm(P1, P2)

    % Build the matrix A
    for i = 1:size(P1, 1)
        A(i, :) = [P2(i,1)*P1(i,1), P2(i,1)*P1(i,2), P2(i,1), P2(i,2)*P1(i,1), P2(i,2)*P1(i,2), P2(i,2), P1(i,1), P1(i,2), 1];
    end
    
    % Compute the SVD decomposition of A
    [U,D,V] = svd(A);
    
    % Select the last column of V as vector f
    f = V(:,end);
    
    % Reshape vector f in a matrix 3x3
    F = reshape(f, [3,3])';

    % Force the rank of F to be 2
    [U,D,V] = svd(F);
    D(3,3) = 0;
    F = U*D*V';
    
end
