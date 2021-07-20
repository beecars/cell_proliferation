function scaled_vol = scaleVol_axialPlane(vol, ref_vol)
%DOWN_AXIALMASK2PET Downsamples first argument (vol) in the axial plane 
%to match the axial plane dimensions of the "ref_vol". The function
%assumes that the axial plane is represented by (:, :, idx). 
%{
Inputs:
    pt_vol - pt volume data.
    mask_vol - mask volume data to downsample. 
Returns: axially-downsampled mask volume.

All the volume data should be oriented as:
    X (1st) axis - coronal plane direction.
    Y (2nd) axis - sagittal plane direction.
    Z (3rd) axis - axial plane direction.
%}

ref_size = size(ref_vol);
ref_dims = [ref_size(1), ref_size(2), ref_size(3)];
scaled_vol  = imresize3(vol, ref_dims, 'nearest');

end

