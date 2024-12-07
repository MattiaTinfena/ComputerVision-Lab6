%% Part 1

P1 = readmatrix('Mire/Mire/Mire1.points', 'FileType', 'text');
P2 = readmatrix('Mire/Mire/Mire2.points', 'FileType', 'text');

P1 = [P1, ones(size(P1, 1), 1)];
P2 = [P2, ones(size(P2, 1), 1)];

% Without normalization
F1 = EightPointsAlgorithm(P1, P2);
disp(F1);

% With normalization
F2 = EightPointsAlgorithmN(P1, P2);
disp(F2);

% Check the epipolar constraint ((x'^_T)Fx=0) holds for all points 
% with the estimated F (both with and without normalization)

threshold = 10^-2;

checkEpipolarConstraint(P1, P2, F1, "mire");
checkEpipolarConstraint(P1, P2, F2, "mire");


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

list_sift = findMatches(mire1, mire2, 'SIFT', 0.75);

pt1 = [list_sift(:, 1:2), ones(size(list_sift, 1), 1)];
pt2 = [list_sift(:, 3:4), ones(size(list_sift, 1), 1)];

% Call the RANSAC function to estimate the optimal F matrix 
% from the correspondences 

[bestF, consensus, outliers] = ransacF(pt1', pt2', threshold);

% Visualize the results and evaluate your estimated F 
% (see Evaluation of the results below)

