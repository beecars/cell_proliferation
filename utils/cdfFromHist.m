function cdf = cdfFromHist(hist)
%CDFFROMHIST From a generic "histogram" array, returns the corresponding 
%            discrete cumulative distribution array.
pdf = hist/sum(hist);
cdf = zeros(1, length(hist));
cum_sum = 0;
for idx = 1:length(hist)
    cdf(idx) = pdf(idx) + cum_sum;
    cum_sum = cdf(idx);
end
end

