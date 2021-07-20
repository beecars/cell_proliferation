function dice = dicescore(prediction, truth)
%DICESCORE Summary of this function goes here
%   Detailed explanation goes here
prediction = double(prediction);
truth = double(truth);
intersection = nnz(prediction .* truth);
dice = (2 * intersection)/(nnz(prediction) + nnz(truth));
end

