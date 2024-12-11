clear all
close all
clc

%% Part 1

threshold = 10^-2;

% Load set of predefined point
P1 = readmatrix('Mire/Mire/Mire1.points', 'FileType', 'text');
P2 = readmatrix('Mire/Mire/Mire2.points', 'FileType', 'text');

% Load a pair of stereo images and resize them
mire1 = imresize(imread('Mire/Mire/Mire1.pgm'), 0.8);
mire2 = imresize(imread('Mire/Mire/Mire2.pgm'), 0.8);

% Homogeneous coordinates
P1_hom = [P1, ones(size(P1, 1), 1)];
P2_hom = [P2, ones(size(P2, 1), 1)];

F1 = EightPointsAlgorithm(P1_hom, P2_hom); % Without normalization
F2 = EightPointsAlgorithmN(P1_hom, P2_hom);% With normalization

resultEvaluation(mire1, mire2, P1, P2, P1_hom, P2_hom, F1, threshold, "Mire without normalization");
resultEvaluation(mire1, mire2, P1, P2, P1_hom, P2_hom, F2, threshold, "Mire with normalization");

%% Part 2 - Acquire and match your own images 10^-2;

% Run the image matching algorithm between the two images, 
% obtaining a set of M correspondences 

list_sift = findMatches(mire1, mire2, 'SIFT', 0.75);
% dividing into two set
pt1 = list_sift(:, 1:2);
pt2 = list_sift(:, 3:4);

% Homogeneous coordinates
pt1_hom = [list_sift(:, 1:2), ones(height(list_sift),1)];
pt2_hom = [list_sift(:, 3:4), ones(height(list_sift),1)];

% Call the RANSAC function to estimate the optimal F matrix 
% from the correspondences 

[bestF, consensus, outliers] = ransacF(pt1_hom', pt2_hom', threshold);
resultEvaluation(mire1, mire2, pt1, pt2, pt1_hom, pt2_hom, bestF, threshold, "Mire with ransac");