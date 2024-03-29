function maxSUV = maxSUV_calculate(pt_vol, mask_vol)
%MAXSUV_CALCULATE function used with "createVertStruct"
% to produce max SUV statistic.

% morphological processing
s = strel([0 1 0; 1 1 1; 0 1 0]);
mask_morph = imerode(mask_vol, s);

% mask the PET data
pt_masked = double(mask_morph) .* double(pt_vol);

% calculate total SUV for pt_vol
maxSUV = max(pt_masked,[], 'all');

end
