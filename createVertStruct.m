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
CURRENTLY these are created manually from DICOM files. They must contain:
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
[~, peaks] = findpeaks(-axial_means/max(axial_means), 'MinPeakHeight', -0.4, 'MinPeakProminence', 0.1);
findpeaks(-axial_means/max(axial_means), 'MinPeakHeight', -0.4, 'MinPeakProminence', 0.1);

% initialize array to hold vert indexes
vertIdxs = zeros(1, 24);
% determine first nonzero value
first_nz_val = getFirstNonZeroIdx(axial_means);
% consider first nonzero value as beginning of L5 vertebrae
vertIdxs(1) = first_nz_val;
% determine the first vertebrae span prior
vert_span = round((peaks(1) - first_nz_val)*1.2);
% if the first vertebrae span prior is less than 5, mitigate error
if vert_span < 5
   vertIdxs(1) = peaks(1);
   vert_span = peaks(2) - peaks(1);
end
% set exclusion zone size
excl = 3;
for i = 1:23
    % get last detected boundary
    last_vert = vertIdxs(i);
    % construct "window", exclude nearest 3 values, extend out to vert_span
    window = axial_means(last_vert+excl:last_vert+vert_span);
    [~, next_vert] = min(window);
    vertIdxs(i+1) = vertIdxs(i)+next_vert+(excl-1);
    % calculate new vertebrae span prior
    vert_span = round((vertIdxs(i+1) - vertIdxs(i))*1.2);

end

% INITIALIZE AND FILL THE STRUCT
vert_labels = {"L5", "L4", "L3", "L2", "L1", "T12", "T11", "T10", "T9", "T8", "T7", "T6", ...
               "T5", "T4", "T3", "T2", "T1", "C7", "C6", "C5", "C4", "C3", "C2"}; %#ok<*CLARRSTR>
vertStruct = struct("vert", vert_labels, "ct_data", [], "pt_data", [], "mask_data", []);

for idx = 1:length(vertStruct)
    % full sized
    vert_ct = ct_interp(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    vertStruct(idx).ct_data = vert_ct;
    vert_mask = mask_morph(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    vertStruct(idx).mask_data = vert_mask;
    vert_pt = maximizePETinMask(pt_scaled(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1)),vertStruct(idx).mask_data, 3);
    vertStruct(idx).pt_data = double(vert_mask) .* vert_pt;

    % SUV
    temp_pt = pt(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    temp_mask = mask_downsampled(:, :, (vertIdxs(idx)+1):(vertIdxs(idx+1)-1));
    aligned_temp_pt = maximizePETinMask(temp_pt, temp_mask, 2);
    vertStruct(idx).pt_data_unscaled = aligned_temp_pt;
    vertStruct(idx).meanSUV = meanSUV_calculate(aligned_temp_pt, temp_mask);
    vertStruct(idx).medianSUV = medianSUV_calculate(aligned_temp_pt, temp_mask);
    vertStruct(idx).maxSUV = maxSUV_calculate(aligned_temp_pt, temp_mask);
    vertStruct(idx).stdSUV = stdSUV_calculate(aligned_temp_pt, temp_mask);

end
end

