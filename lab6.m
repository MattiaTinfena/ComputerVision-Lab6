clear all
close all
clc

%% Part 1

threshold = 10^-2;

% Load set of predefined point
% Mire
P1 = readmatrix('Mire/Mire/Mire1.points', 'FileType', 'text');
P2 = readmatrix('Mire/Mire/Mire2.points', 'FileType', 'text');

% Rubik
P3 = readmatrix('Rubik/Rubik/Rubik1.points', 'FileType', 'text');
P4 = readmatrix('Rubik/Rubik/Rubik2.points', 'FileType', 'text');


% Load a pair of stereo images and resize them
% Mire
mire1 = imresize(imread('Mire/Mire/Mire1.pgm'), 0.8);
mire2 = imresize(imread('Mire/Mire/Mire2.pgm'), 0.8);

% Rubik
rub1 = imresize(imread('Rubik/Rubik/Rubik1.pgm'), 0.8);
rub2 = imresize(imread('Rubik/Rubik/Rubik2.pgm'), 0.8);

% Our images
img1 = rgb2gray(imread('Img/img1.jpg'));
img2 = rgb2gray(imread('Img/img2.jpg'));

% Homogeneous coordinates
% Mire
P1_hom = [P1, ones(size(P1, 1), 1)];
P2_hom = [P2, ones(size(P2, 1), 1)];

% Rubik
P3_hom = [P3, ones(size(P3, 1), 1)];
P4_hom = [P4, ones(size(P4, 1), 1)];

% Building the fundamental matrices with and without normalization
% Mire
Fm1 = EightPointsAlgorithm(P1_hom, P2_hom); % Without normalization
Fm2 = EightPointsAlgorithmN(P1_hom, P2_hom); % With normalization

% Rubik
Fr1= EightPointsAlgorithm(P3_hom, P4_hom); % Without normalization
Fr2 = EightPointsAlgorithmN(P3_hom, P4_hom); % With normalization

% Plotting the evalutation
% Mire
resultEvaluation(mire1, mire2, P1, P2, P1_hom, P2_hom, Fm1, threshold, "Mire without normalization");
resultEvaluation(mire1, mire2, P1, P2, P1_hom, P2_hom, Fm2, threshold, "Mire with normalization");

% Rubik
resultEvaluation(rub1, rub2, P3, P4, P3_hom, P4_hom, Fr1, threshold, "Rubik without normalization");
resultEvaluation(rub1, rub2, P3, P4, P3_hom, P4_hom, Fr2, threshold, "Rubik with normalization");

%% Part 2 - Acquire and match your own images 10^-2;

% Run the image matching algorithm between the two images, obtaining a set of M correspondences 
list_sift_m = findMatches(mire1, mire2, 'SIFT', 0.05); % Mire
list_sift_r = findMatches(rub1, rub2, 'SIFT', 0.05); % Rubik
list_sift_i = findMatches(img1, img2, 'SIFT', 0.05); % Our images

% Dividing into two set and making them homogeneous
% Mire
pt1_m = list_sift_m(:, [2, 1]);
pt2_m = list_sift_m(:, [4, 3]);

pt1_hom_m = [pt1_m, ones(height(list_sift_m),1)];
pt2_hom_m = [pt2_m, ones(height(list_sift_m),1)];

% Rubik
pt1_r = list_sift_r(:, [2, 1]);
pt2_r = list_sift_r(:, [4, 3]);

pt1_hom_r = [pt1_r, ones(height(list_sift_r),1)];
pt2_hom_r = [pt2_r, ones(height(list_sift_r),1)];

% Our images
pt1_i = list_sift_i(:, [2, 1]);
pt2_i = list_sift_i(:, [4, 3]);

pt1_hom_i = [pt1_i, ones(height(list_sift_i),1)];
pt2_hom_i = [pt2_i, ones(height(list_sift_i),1)];

% Call the RANSAC function to estimate the optimal F matrix from the correspondences 
% Mire
[bestF_m, consensus_m, outliers_m] = ransacF(pt1_hom_m', pt2_hom_m', 10^-4);
resultEvaluation(mire1, mire2, pt1_m, pt2_m, pt1_hom_m, pt2_hom_m, bestF_m, 10^-8, "Mire with ransac");

% Rubik
[bestF_r, consensus_r, outliers_r] = ransacF(pt1_hom_r', pt2_hom_r', 10^-4);
resultEvaluation(rub1, rub2, pt1_r, pt2_r, pt1_hom_r, pt2_hom_r, bestF_r, 10^-8, "Rubik with ransac");

% Our images
[bestF_i, consensus_i, outliers_i] = ransacF(pt1_hom_i', pt2_hom_i', 10^-4);
resultEvaluation(img1, img2, pt1_i, pt2_i, pt1_hom_i, pt2_hom_i, bestF_i, 10^-8, "Image with ransac");

