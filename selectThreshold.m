function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;


stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    

    %compute prediction vector
    m = size(pval, 1);
    cvPredictions = zeros(m,1);
    
    for i = 1:m
        if pval(i) < epsilon
            cvPredictions(i) = 1;
        else
            cvPredictions(i) = 0;
        end
    end

    %calculate F1 score
    %F1 = (2 * precision * recall) / (precision + recall)
    %precision = true positives / (true positives + false positives)
    %recall =true positives / (true positives + false negatives)

    %true positives
    tp = sum((cvPredictions == 1) & (yval == 1));
    %false positives
    fp = sum((cvPredictions == 1) & (yval == 0));
    %false negatives
    fn = sum((cvPredictions == 0) & (yval == 1));
    % precision
    prec = tp / (tp + fp);
    %recall
    rec = tp / (tp + fn);
    % f1 score
    F1 = (2 * prec * rec) / (prec + rec);

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end

%======== test case ========

%{
    input:
    yval = [1 0 0 1 1]';
    pval = [0.1 0.2 0.3 0.4 0.5]';

    [epsilon F1] = selectThreshold(yval, pval)
    output:
    epsilon =  0.40040
    F1 =  0.57143

}