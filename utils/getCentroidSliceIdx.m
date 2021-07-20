function centroid_idx = getCentroidSliceIdx(mask_volume)
%GETCENTROIDSLICEIDX Finds the approximate center slice by constructing a 
%                    histogram of the number of mask pixels in successive 
%                    slices and finding the mean.
n_slices = size(mask_volume, 2);
area_hist = zeros(1, n_slices);
for slice_idx = 1:n_slices
    slice = mask_volume(:, slice_idx, :);
    area = nnz(slice);
    area_hist(slice_idx) = area;
end
cdf = cdfFromHist(area_hist);
cdf_diff_target = abs(cdf - 0.5);
[~,centroid_idx] = min(cdf_diff_target);
end

