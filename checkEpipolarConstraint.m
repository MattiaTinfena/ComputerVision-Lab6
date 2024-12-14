function checkEpipolarConstraint(P1, P2, F, threshold,label)
    % Compute epipolar residuals for all point correspondences
    residuals = zeros(size(P1, 1), 1);

    for i = 1:height(P1)
        x1 = P1(i, :); 
        x2 = P2(i, :);
        residuals(i) = abs(x2 * F * x1'); % Epipolar constraint
    end

    b = 0;
    for i = 1:1:size(residuals, 1)
        if(residuals(i) > threshold)  
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