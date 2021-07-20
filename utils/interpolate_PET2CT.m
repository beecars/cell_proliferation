function pt_interp2CT = interpolate_PET2CT(unreg_scan_datafile)
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
    X (1st) axis - ??? plane direction.
    Y (2nd) axis - ??? plane direction.
    Z (3rd) axis - axial plane direction.
%}

% LOAD DATA
load(unreg_scan_datafile, 'ct', 'pt', 'ct_info', 'pt_info');
% resize axial dimension to match CT dimensions.
ct_size = size(ct);
pt_size = size(pt);
interp_dims = [ct_size(1), ct_size(2), pt_size(3)];
pt_resized = imresize3(pt, interp_dims);

% DEFINE SAMPLE GRIDS
% get params for z axis sample meshgrid.
pt_z_spacing = pt_info.SliceThickness;
pt_z_locations = abs(extractfield(pt_info, 'SliceLocation'));
pt_z_start = min(pt_z_locations);
pt_z_end = max(pt_z_locations) + 1;
% construct the meshgrids.
[Xs, Ys, Zs] = meshgrid(0:1:ct_size(1)-1, ...
                        0:1:ct_size(2)-1, ...
                        pt_z_start:pt_z_spacing:pt_z_end);        

% DEFINE QUERY GRIDS (interpolation grid)
% get params for z axis query meshgrid. 
ct_z_spacing = ct_info.SliceThickness;
ct_z_locations = abs(extractfield(ct_info, 'SliceLocation'));
if abs(min(ct_z_locations) - min(pt_z_locations)) > 100
    ct_z_locations = -ct_z_locations;
ct_z_start = min(ct_z_locations);
ct_z_end = max(ct_z_locations) + 1;
% construct the meshgrids.
[Xq, Yq, Zq] = meshgrid(0:1:ct_size(1)-1, ...
                        0:1:ct_size(2)-1, ...
                        ct_z_start:ct_z_spacing:ct_z_end);

pt_interp2CT = interp3(Xs, Ys, Zs, pt_resized, Xq, Yq, Zq, 'linear');
pt_interp2CT(isnan(pt_interp2CT)) = 0;

clear ct_size ct_z_end ct_z_locations ct_z_spacing ct_z_start ...
      interp_dims pt_resized pt_size pt_z_end pt_z_start pt_z_locations ...
      pt_z_spacing pt_z_start Xq Yq Zq Xs Ys Zs
  
end