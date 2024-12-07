function checkEpipolarConstraint(P1, P2, F, label)
    % Compute epipolar residuals for all point correspondences
    tr = 10^-2;
    residuals = zeros(size(P1, 1), 1);

    for i = 1:height(P1)
        x1 = P1(i, :); % Homogeneous point in image 1
        x2 = P2(i, :); % Homogeneous point in image 2
        residuals(i) = abs(x2 * F * x1'); % Epipolar constraint
    end

    b = 0;
    for i = 1:1:size(residuals)
        if(residuals(i) > tr)  
            b = 1;
            break;
        end
    end
        % Display Results
    fprintf('\nResiduals for %s:\n', label);
    disp(residuals);
    fprintf('Mean residual: %.6f\n', mean(residuals));
    fprintf('Max residual: %.6f\n', max(residuals));
    
    if(b==1)
        disp("Some epipolar constraint are not respected!");
    else
        disp("All epipolar constraint are respected!");
    end

end