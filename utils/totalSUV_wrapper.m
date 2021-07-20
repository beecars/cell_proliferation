function totalSUV = totalSUV_wrapper(pd_idx, mask_name)
%TOTALSUV_WRAPPER a wrapper for calculating total SUV from a 
%given object class name (string) and a pd_idx [patient_idx, day_idx] 
%associated with a "ct_pt_matfile" and a "mask_matfile" described 
%further below in this README.

ct_pt_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + ".mat";
mask_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + "_pred.mat";

% interpolate mask volume to match PET axial scan locations
mask_interp = interpolate_mask2PET(ct_pt_matfile, mask_matfile, mask_name);
load(ct_pt_matfile, 'pt');

% downsample mask in axial plane to match PET axial dimensions
mask_down = scaleVol_axialPlane(mask_interp, pt);

% morphological post-processing
s = strel('sphere', 1);
mask_morph = imdilate(mask_down, s);

% mask the PET data
pt_masked = mask_morph .* pt;

% calculate total SUV for pt_vol
totalSUV = sum(pt_masked, 'all');

end

