function [] = resultEvaluation(img1, img2, P1, P2, P1_hom, P2_hom, F, threshold, title)
disp("---------------")
disp(title)

% Visualize the results and evaluate your estimated F
disp("Matrix F:")
disp(F);

% Check the epipolar constraint ((x'^_T)Fx=0) holds for all points 
% with the estimated F (both with and without normalization)
checkEpipolarConstraint(P1_hom, P2_hom, F, threshold, title);

% Visualize the stereo pairs with epipolar lines of the corresponding points 
% (use the function visualizeEpipolarLines provided with the Lab material) 
visualizeEpipolarLines(img1, img2, F, P1, P2);

% Have a look at the epipoles.
[left_ep, right_ep] = computeEpipolar(F);
fprintf('\nLeft epipolar \t Right epipolar\n')
for i=1:3
    fprintf("%f \t\t %f\n", left_ep(i), right_ep(i));
end
disp("--------------")
end