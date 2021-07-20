function tpr = tpr(prediction, truth)
%DICESCORE Summary of this function goes here
%   Detailed explanation goes here
prediction = logical(prediction);
truth = logical(truth);
intersection = nnz(prediction .* truth);
tpr = intersection/nnz(truth);
end

