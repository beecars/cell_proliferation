function mask_interp2PET = interpolate_mask2PET(ct_pt_matfile, mask_matfile, mask_name)
%{
Function for interpolating (matching) PET scan data to undersampled CT scan
slice locations. Uses MATLAB built-in "interp3" function.

Requires a string input ("unreg_scan_datafile") pointing to a .mat file 
with the following variables:
    ct - CT volume data
    ct_info - CT metadata struct with fields "SliceThickness" and "SliceLocation"
    pt - PET volume data
    pt_info - PET metadata struct with fields "SliceThickness" and "SliceLocation"
    
All the volume data should be oriented as:
    X (1st) axis - coronal plane direction.
    Y (2nd) axis - sagittal plane direction.
    Z (3rd) axis - axial plane direction.
%}

% LOAD DATA
load(ct_pt_matfile, 'ct_info', 'pt_info');
mask_struct = load(mask_matfile, mask_name);
mask = mask_struct.(mask_name);
% define dimensions of volume data
mask_size = size(mask);
% DEFINE SAMPLE GRIDS
% get params for z axis sample meshgrid.
mask_z_spacing = ct_info.SliceThickness;
mask_z_locations = extractfield(ct_info, 'SliceLocation');
mask_z_start = min(mask_z_locations);
mask_z_end = max(mask_z_locations) + 1;
% construct the meshgrids.
[Xs, Ys, Zs] = meshgrid(0:1:mask_size(1)-1, ...
                        0:1:mask_size(2)-1, ...
                        mask_z_start:mask_z_spacing:mask_z_end);        

% DEFINE QUERY GRIDS (interpolation grid)
% get params for z axis query meshgrid.
pt_z_spacing = pt_info.SliceThickness;
pt_z_locations = -extractfield(pt_info, 'SliceLocation');
pt_z_start = min(pt_z_locations);
pt_z_end = max(pt_z_locations) + 1;
% construct the meshgrids.
[Xq, Yq, Zq] = meshgrid(0:1:mask_size(1)-1, ...
                        0:1:mask_size(2)-1, ...
                        pt_z_start:pt_z_spacing:pt_z_end);

mask_interp2PET = interp3(Xs, Ys, Zs, mask, Xq, Yq, Zq, 'cubic');
mask_interp2PET(isnan(mask_interp2PET)) = 0;

clear mask_size mask_z_end mask_z_locations mask_z_spacing mask_z_start ...
      interp_dims pt_resized pt_size pt_z_end pt_z_start pt_z_locations ...
      pt_z_spacing pt_z_start Xq Yq Zq Xs Ys Zs
  
end