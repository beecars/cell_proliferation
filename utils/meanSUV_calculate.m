function meanSUV = meanSUV_calculate(pt_vol, mask_vol)
%MEANSUV_EXTRACTION function used with "createVertStruct"
%to produce total SUV content alongside the other struct fields 
%for the individually segmented vertebrae. 

% morphological processing
s = strel([0 1 0; 1 1 1; 0 1 0]);
mask_morph = imerode(mask_vol, s);

% mask the PET data
pt_masked = double(mask_morph) .* double(pt_vol);

% calculate total SUV for pt_vol
meanSUV = sum(pt_masked, 'all')/nnz(mask_morph);

end
