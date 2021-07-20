function [vertStruct, vertIdxs] = createVertStruct(pd_idx)
%CREATEVERTSTRUCT Performs a very specific instance segmentation task.
%{   
Bound the lumbar and thoracic vertebrae by axial slices from FLT-PET scans 
taken on or near the 28th day post-transplant of a hematopoietic stem-cell 
transplant patient. This is then combined with a volume mask of the 
vertebral column to get individually segmented vertebrae. The vertebral 
instance segmentation masks and their associated CT and PET data are stored
in a struct with their anatomical label ("L5, "L4", ...). They are stored
in two formats: full-sized and truncated to remove any remnant
"zero padding" from the volumes. 

returns:
vertStruct - a struct containing the data outlined above. 
vertIdxs - the axial indexes detected to be vertebral boundaries by the 
           algorithm described in my master's thesis. Starts from "bottom"
           bound of L5 and continues to "top" bound of T1. 

REQUIRES:
SEGMENTATION VOLUME MATFILE
I am getting these from a UNet described in my master's thesis. The 
dimensions must match the dimensionsof the CT datafile. It must contain:
    spine - A segmentation volume of the vertebral column. It works with 
            binary masks but should also work with raw predictions ranging 
            [0, 1] with a p = 0.5 classification threshold. 

CT/PT VOLUME DATA MATFILE
These are created manually from DICOM files. They must contain:
    ct - CT volume data 
    ct_info - CT metadata struct with fields "SliceThickness" and "SliceLocation"
    pt - PET volume data
    pt_info - PET metadata struct with fields "SliceThickness" and "SliceLocation"
    * the CT data and metadata is required to interpolate the mask volumes 
      to the PET coordinate system. 
    
All the volume data should be oriented as:
    X (1st) axis - coronal plane direction.
    Y (2nd) axis - sagittal plane direction.
    Z (3rd) axis - axial plane direction.
%}

% LOAD AND PREPROCESS DATA
ct_pt_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + ".mat";
mask_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + "_pred.mat";
% load PET data
load(ct_pt_matfile, 'pt'); %LR PET data
pt_scaled = scale_axialPET2CT(ct_pt_matfile);
% load CT data
ct_interp = interpolate_CT2PET(ct_pt_matfile);
% interpolate spine mask to axial locations of PET data (for segmentation)
mask_interp = interpolate_mask2PET(ct_pt_matfile, mask_matfile, 'spine');
mask_interp = uint8(imbinarize(mask_interp, 0.00001));
mask_downsampled = scaleVol_axialPlane(mask_interp, pt);
% extract largest connected component
mask_morph = extractLargestComponent3D(mask_interp);

pt_masked = double(pt_scaled) .* double(mask_morph);
axial_means = zeros(size(pt_scaled,3), 1);
for idx = 1:size(pt_scaled,3)
    axial_means(idx) = sum(pt_masked(:, :, idx), 'all')/nnz(pt_masked(:, :, idx));
end
axial_means(isnan(axial_means)) = 0;
[~, locs] = findpeaks(-axial_means, 'MinPeakDistance', 5, 'MinPeakProminence', abs(max(axial_means)/5));

% The algorithm below is fully explained in my master's thesis. 

first_idx = getFirstNonZeroIdx(axial_means);
first_idx_2_next = locs(1) - first_idx;
l4_span = locs(2) - locs(1);
first_span_prior = ceil(5/4*(l4_span));
if first_idx_2_next < round(first_span_prior*3/4)
    first_idx = locs(1);
end

span_prior = first_span_prior;
vertIdxs = [first_idx];
for i = 1:18
    last_vert_idx = vertIdxs(end);
    next_vert_possible = axial_means(last_vert_idx+3:last_vert_idx+span_prior);
    [~, next_vert] = min(next_vert_possible);
    vertIdxs = [vertIdxs; vertIdxs(end)+next_vert+2];
    if i == 9
        span_prior = ceil(l4_span);
    elseif i == 12
        span_prior = ceil(l4_span*4/5);
    elseif i == 16
        span_prior = ceil(l4_span*3/5);
    end
end

if (vertIdxs(2) - vertIdxs(1)) < round(first_span_prior*3/5)
    vertIdxs(1) = [];
end

% INITIALIZE AND FILL THE STRUCT
vert_labels = {"L5", "L4", "L3", "L2", "L1", "T12", "T11", "T10", "T9", "T8", "T7", "T6", ...
               "T5", "T4", "T3", "T2", "T1"}; %#ok<*CLARRSTR> 
vertStruct = struct("vert", vert_labels, "ct_data", [], "ct_data_s", [], ...
               "pt_data", [], "pt_data_s", [], "mask_data", [], ...
               "mask_data_s", []);

for idx = 1:length(vertStruct)
    % full sized
    vert_ct = ct_interp(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    vertStruct(idx).ct_data = vert_ct;
    vert_mask = mask_morph(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    vertStruct(idx).mask_data = vert_mask;
    vert_pt = pt_scaled(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    vertStruct(idx).pt_data = double(vert_mask) .* vert_pt;
    
    % minimal 
    vertStruct(idx).pt_data_s = removePadding3D(vertStruct(idx).pt_data);
    vertStruct(idx).mask_data_s = removePadding3D(vertStruct(idx).mask_data);
    vertStruct(idx).ct_data_s = removePadding3D(vertStruct(idx).ct_data);
    
    % total SUV
    vertStruct(idx).totalSUV = totalSUV_dilateAxialPlane( ...
        pt(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1)), ...
        mask_downsampled(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1)));
end

end

