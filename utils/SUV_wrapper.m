function SUV_stats = SUV_wrapper(pd_idx, mask_name)
%SUV_WRAPPER a wrapper for calculating various SUV statistics from a
% given object class name (string) and a pd_idx [patient_idx, day_idx]
% associated with a "ct_pt_matfile" and a "mask_matfile" described
% further below in this README.

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
pt_masked = mask_morph .* maximizePETinMask(pt, mask_morph, 3);

% compute pct voxels gtr than 1.4 SUV uptake
pt_gtr_14 = pt_masked > 1.4;
pct_gtr_14 = nnz(pt_gtr_14)/nnz(pt_masked)*100;

% calculate total SUV for pt_vol
SUV_stats.pct_gtr_14 = pct_gtr_14;
SUV_stats.meanSUV = sum(pt_masked, 'all')/nnz(pt_masked);
SUV_stats.maxSUV = max(pt_masked,[], 'all');
SUV_stats.stdSUV = std(pt_masked, 1, 'all');
pt_masked(pt_masked == 0) = NaN;
SUV_stats.medianSUV = median(pt_masked, 'all', 'omitnan');

end