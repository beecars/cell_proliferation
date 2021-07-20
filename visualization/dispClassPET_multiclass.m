function fig = dispClassPET_multiclass(pd_idx, classes)
    fig = figure();
    mask_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + "_pred.mat";
    ct_pt_matfile = "patient" + pd_idx(1) + "_day" + pd_idx(2) + ".mat";
    pt_scaled = scale_axialPET2CT(mask_matfile);
    construction_volume = zeros(size(pt_scaled,1), size(pt_scaled,2), size(pt_scaled,3));
    construction_volume = uint8(construction_volume);
    for idx = 1:length(classes)
        mask_interp = interpolate_mask2PET(ct_pt_matfile, mask_matfile, classes(idx));
        mask_interp = uint8(imbinarize(mask_interp, 0.00001));
        mask_interp = extractLargestComponent3D(mask_interp);
        construction_volume = construction_volume + mask_interp;
    end
    pt_masked = double(construction_volume) .* pt_scaled;
    pt_masked_nan = pt_masked;
    pt_masked_nan(pt_masked_nan == 0) = NaN;
    [pt_hist_counts, pt_hist_edges] = histcounts(pt_masked_nan);
    pt_cdf = cdfFromHist(pt_hist_counts);
    cdf_idx_1 = getClosestValueIdx(pt_cdf, 0.50);
    iso_val_1 = pt_hist_edges(cdf_idx_1);
    cdf_idx_2 = getClosestValueIdx(pt_cdf, 0.85);
    iso_val_2 = pt_hist_edges(cdf_idx_2);
    cdf_idx_3 = getClosestValueIdx(pt_cdf, 0.98);
    iso_val_3 = pt_hist_edges(cdf_idx_3);
    fv0 = isosurface(pt_masked, 0.0001);
    fv1 = isosurface(pt_masked, iso_val_1);
    fv2 = isosurface(pt_masked, iso_val_2);
    fv3 = isosurface(pt_masked, iso_val_3);
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.05;
    p1 = patch(fv1,'FaceColor', 'yellow','EdgeColor','none');
    p1.FaceAlpha = 0.2;
    p2 = patch(fv2,'FaceColor', 'red','EdgeColor','none');
    p2.FaceAlpha = 0.3;
    p2 = patch(fv3,'FaceColor', 'black','EdgeColor','none');
    p2.FaceAlpha = 1;
    xticks([]);
    yticks([]);
    zticks([]);
    view(3)
    daspect([1,1,1/3])
    axis tight
    camlight
    camlight(-80,-10)
    lighting flat
    title("\fontsize{14}p" + pd_idx(1) + "d" + pd_idx(2));

end

