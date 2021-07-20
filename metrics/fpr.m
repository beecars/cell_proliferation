function fpr = fpr(prediction, truth)
%DICESCORE Summary of this function goes here
%   Detailed explanation goes here
prediction = logical(prediction);
truth = logical(truth);
not_truth = ~truth;
false_intersection = nnz(prediction .* not_truth);
fpr = false_intersection/nnz(not_truth);
end

