function pt_scaled = scale_axialPET2CT(ct_pt_datafile)
%{
SCALE_AXIALPET2CT
Function for interpolating (matching) PET scan data to
undersampled CT scan slice locations. Uses MATLAB built-in "interp3" function.

Requires a string input ("ct_pt_datafile") pointing to a .mat file
with the following variables:
    ct - CT volume data
    pt - PT volume data

All the volume data should be oriented as:
    X (1st) axis - coronal plane direction.
    Y (2nd) axis - sagittal plane direction.
    Z (3rd) axis - axial plane direction.
%}

% LOAD DATA
load(ct_pt_datafile, 'ct', 'pt')
% resize axial dimension to match CT dimensions.
ct_size = size(ct);
pt_size = size(pt);
interp_dims = [ct_size(1), ct_size(2), pt_size(3)];
pt_scaled = imresize3(pt, interp_dims);

end