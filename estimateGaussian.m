function [mu sigma2] = estimateGaussian(X)
%ESTIMATEGAUSSIAN This function estimates the parameters of a 
%Gaussian distribution using the data in X
%   [mu sigma2] = estimateGaussian(X), 
%   The input X is the dataset with each n-dimensional data point in one row
%   The output is an n-dimensional vector mu, the mean of the data set
%   and the variances sigma^2, an n x 1 vector
% 

% Useful variables
[m, n] = size(X);

mu = mean(X);
%can't use var function cause it uses 1/(m-1) instead of 1/m
sigma2 = 1/m * sum((X - mu).^2);

end

%{
%======== test case =========

X = sin(magic(4));
X = X(:,1:3);
[mu sigma2] = estimateGaussian(X)
output:
mu =
  -0.3978779  0.3892253  -0.0080072
sigma2 =
   0.27795    0.65844   0.20414
}