# ComputerVision-Lab6
## Fundamental Matrix Estimation and Epipolar Geometry

MATLAB project studying two-view geometry through fundamental-matrix estimation, feature matching and robust model fitting.

### Methods

- Eight-point algorithm with and without coordinate normalisation.
- Fundamental-matrix estimation from supplied point correspondences.
- FAST keypoint detection and SURF descriptor extraction, followed by feature matching.
- RANSAC-based estimation in the presence of mismatched correspondences.
- Epipolar-constraint evaluation, epipole computation and epipolar-line visualisation.

### Requirements

MATLAB with Image Processing Toolbox and Computer Vision Toolbox, including `detectFASTFeatures` and SURF descriptor extraction. The code labels one matching mode `SIFT`, but its current feature-extraction implementation uses FAST and SURF.

### Run

```bash
git clone https://github.com/MattiaTinfena/ComputerVision-Lab6.git
```

Set the repository root as MATLAB’s current folder and run:

```matlab
lab6
```

Preserve the `Mire/`, `Rubik/` and `Img/` directory structure: the main script reads images and point files using relative paths.

### Main files

- `EightPointsAlgorithm.m` / `EightPointsAlgorithmN.m`: estimation without/with normalisation.
- `findMatches.m`: feature matching.
- `ransacF.m`: robust estimation.
- `resultEvaluation.m`: evaluation and plots.
- `visualizeEpipolarLines.m`: epipolar-line rendering.

### Documentation

See the [project report](BuonoMartinenghiTinfena_lab6_report.pdf) for the experimental discussion. RANSAC results can vary between runs unless the random state is fixed.
