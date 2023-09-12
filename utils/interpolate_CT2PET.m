function ct_interp2PET = interpolate_CT2PET(unreg_scan_datafile)
%{
INTERPOLATE_CT2PET
Function for interpolating (matching) CT scan data to PET scan
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
load(unreg_scan_datafile, 'ct', 'ct_info', 'pt_info');
% define dimensions of volume data
ct_size = size(ct);
% DEFINE SAMPLE GRIDS
% get params for z axis sample meshgrid.
ct_z_spacing = ct_info.SliceThickness;
ct_z_locations = extractfield(ct_info, 'SliceLocation');
ct_z_start = min(ct_z_locations);
ct_z_end = max(ct_z_locations) + 1;
% construct the meshgrids.
[Xs, Ys, Zs] = meshgrid(0:1:ct_size(1)-1, ...
                        0:1:ct_size(2)-1, ...
                        ct_z_start:ct_z_spacing:ct_z_end);

% DEFINE QUERY GRIDS (interpolation grid)
% get params for z axis query meshgrid.
pt_z_spacing = pt_info.SliceThickness;
pt_z_locations = -extractfield(pt_info, 'SliceLocation');
pt_z_start = min(pt_z_locations);
pt_z_end = max(pt_z_locations) + 1;
% construct the meshgrids.
[Xq, Yq, Zq] = meshgrid(0:1:ct_size(1)-1, ...
                        0:1:ct_size(2)-1, ...
                        pt_z_start:pt_z_spacing:pt_z_end);

ct_interp2PET = interp3(Xs, Ys, Zs, ct, Xq, Yq, Zq, 'linear');
ct_interp2PET(isnan(ct_interp2PET)) = 0;

clear ct_size ct_z_end ct_z_locations ct_z_spacing ct_z_start ...
      interp_dims pt_resized pt_size pt_z_end pt_z_start pt_z_locations ...
      pt_z_spacing pt_z_start Xq Yq Zq Xs Ys Zs

end