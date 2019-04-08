% anomaly detection on a complex data set

%% Initialization
clear ; close all; clc

fprintf('Loading data... \n')
load('anomalyData.mat');

fprintf('Calculating Gaussian fit... \n')
%  Estimate and sigma2
[mu sigma2] = estimateGaussian(X);
fprintf('Training... \n')
%  Training set 
p = multivariateGaussian(X, mu, sigma2);
%  Cross-validation set
pval = multivariateGaussian(Xval, mu, sigma2);
fprintf('Finding best threshold epsilon... \n')
%  Find the best threshold
[epsilon F1] = selectThreshold(yval, pval);
input('Press enter')

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);
fprintf('# Outliers found: %d\n\n', sum(p < epsilon));

