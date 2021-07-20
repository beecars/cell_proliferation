function totalSUV = totalSUV_dilateAxialPlane(pt_vol, mask_vol)
%TOTALSUV_EXTRACTION function used with "createVertStruct"
%to produce total SUV content alongside the other struct fields 
%for the individually segmented vertebrae. 

% morphological processing
s = strel([0 1 0; 1 1 1; 0 1 0]);
mask_morph = imdilate(mask_vol, s);

% mask the PET data
pt_masked = double(mask_morph) .* double(pt_vol);

% calculate total SUV for pt_vol
totalSUV = sum(pt_masked, 'all');

end
