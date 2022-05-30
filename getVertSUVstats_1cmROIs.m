function SUV_stats_1cm = getVertSUVstats_1cmROIs(vertStruct)

SUV_stats_1cm = struct("meanSUV", [], "maxSUV", [], "medSUV", [], "stdSUV", []);
verts = length(vertStruct);

for idx = 1:verts
    % load pt data for vert
    vert_SUV_data = vertStruct(idx).pt_data_unscaled;
    % mask the top 50% SUV voxels
    [pt_hist_counts, pt_hist_edges] = histcounts(vert_SUV_data);
    pt_cdf = cdfFromHist(pt_hist_counts);
    cdf_idx_1 = getClosestValueIdx(pt_cdf, 0.50);
    SUV_threshold_50th = pt_hist_edges(cdf_idx_1);
    vert_SUV_mask_50th = vert_SUV_data > SUV_threshold_50th;
    % find the centroid of the 50th percentile mask
    centroid_idxs = getCentroid(vert_SUV_mask_50th);

end

