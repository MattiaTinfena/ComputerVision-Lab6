mire1 = imread("Mire\Mire\Mire1.pgm");
mire2 = imread("Mire\Mire\Mire2.pgm");


% figure
% subplot(1, 2, 1)
% imshow(mire1), title("Mire 1");
% subplot(1, 2, 2)
% imshow(mire2), title("Mire 2")

F = EightPointsAlgorithm(mire1, mire2);
disp(F);
F = EightPointsAlgorithmN(mire1, mire2);
disp(F);