%% Part 1


mire1 = readmatrix('Mire/Mire/Mire1.points', 'FileType', 'text');
mire2 = readmatrix('Mire/Mire/Mire2.points', 'FileType', 'text');

mire1 = [mire1, ones(size(mire1, 1), 1)]';
mire2 = [mire2, ones(size(mire2, 1), 1)]';

F1 = EightPointsAlgorithm(mire1, mire2);
disp(F1);

F2 = EightPointsAlgorithmN(mire1, mire2);
disp(F2);

% Check the epipolar constraint (x'TFx=0) holds for all points 
% with the estimated F (both with and without normalization)
check_epipolar1 = mire1' * F1 * mire2;
check_epipolar2 = mire1' * F2 * mire2;

ep1 = ones(1, size(check_epipolar1, 2));
ep2 = ones(1, size(check_epipolar2, 2));

for i = 1:size(check_epipolar1, 1)
    ep1(i) = check_epipolar1(i, i);
    ep2(i) = check_epipolar2(i, i);
end
disp("ep1");
disp(ep1);
disp("ep2");
disp(ep2);



%% Part 2 - Acquire and match your own images

% Load a pair of stereo images
mire1 = imread('Mire/Mire/Mire1.pgm');
mire2 = imread('Mire/Mire/Mire2.pgm');

mire1 = imresize(mire1, 0.8);
mire2 = imresize(mire2, 0.8);

figure
subplot(1, 2, 1)
imshow(mire1), title("Mire 1");
subplot(1, 2, 2)
imshow(mire2), title("Mire 2")


% Run the image matching algorithm between the two images, 
% obtaining a set of M correspondences 
% (presumably, some of them will be wrong/noisy)
% list_pos = findMatches(mire1, mire2, 'POS', 0.95);
% list_ncc = findMatches(mire1, mire2, 'NCC', 0.45);
% list_sift = findMatches(mire1, mire2, 'SIFT', 0.75);

% Call the RANSAC function to estimate the optimal F matrix 
% from the correspondences 
%[bestF, consensus, outliers] = ransacF(P1, P2, th);

% Visualize the results and evaluate your estimated F 
% (see Evaluation of the results below)

