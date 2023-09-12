function medianSUV = medianSUV_calculate(pt_vol, mask_vol)
%MEDIANSUV_CALCULATE function used with "createVertStruct"
% to produce median SUV statistic.

% morphological processing
s = strel([0 1 0; 1 1 1; 0 1 0]);
mask_morph = imerode(mask_vol, s);

% mask the PET data
pt_masked = double(mask_morph) .* double(pt_vol);

% calculate total SUV for pt_vol
pt_masked(pt_masked == 0) = NaN;
medianSUV = median(pt_masked, 'all', 'omitnan');

end
