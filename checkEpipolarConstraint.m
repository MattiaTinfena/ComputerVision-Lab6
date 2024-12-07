function checkEpipolarConstraint(P1, P2, F, label)
    % Compute epipolar residuals for all point correspondences
    num_points = size(P1, 2);
    residuals = zeros(1, num_points);
    for i = 1:num_points
        x1 = P1(:, i); % Homogeneous point in image 1
        x2 = P2(:, i); % Homogeneous point in image 2
        residuals(i) = abs(x2' * F * x1); % Epipolar constraint
    end
        % Display Results
    fprintf('\nResiduals for %s:\n', label);
    disp(residuals);
    fprintf('Mean residual: %.6f\n', mean(residuals));
    fprintf('Max residual: %.6f\n', max(residuals));
end