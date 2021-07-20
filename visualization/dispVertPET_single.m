function dispVertPET_single(pd_idx, vert_idx)

    set(0,'DefaultTextFontname', 'LM Sans 12')
    set(0,'DefaultAxesFontName', 'LM Sans 12')

    vertStruct = createVertStruct(pd_idx);

    zs = zeros(512);
    vert3d = cat(3, zs, vertStruct(vert_idx).pt_data, zs);

    vert3d_nan = vert3d;
    vert3d_nan(vert3d_nan == 0) = NaN;
    [pt_hist_counts, pt_hist_edges] = histcounts(vert3d_nan);
    pt_cdf = cdfFromHist(pt_hist_counts);
    cdf_idx_1 = getClosestValueIdx(pt_cdf, 0.50);
    iso_val_1 = pt_hist_edges(cdf_idx_1);
    cdf_idx_2 = getClosestValueIdx(pt_cdf, 0.85);
    iso_val_2 = pt_hist_edges(cdf_idx_2);
    cdf_idx_3 = getClosestValueIdx(pt_cdf, 0.98);
    iso_val_3 = pt_hist_edges(cdf_idx_3);

    fv0 = isosurface(vert3d, 0);
    fv1 = isosurface(vert3d, iso_val_1);
    fv2 = isosurface(vert3d, iso_val_2);
    fv3 = isosurface(vert3d, iso_val_3);

    figure
    colormap("lines")
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.05;
    p1 = patch(fv1,'FaceColor', 'yellow','EdgeColor','none');
    p1.FaceAlpha = 0.2;
    p2 = patch(fv2,'FaceColor', 'red','EdgeColor','none');
    p2.FaceAlpha = 0.3;
    p2 = patch(fv3,'FaceColor', 'black','EdgeColor','none');
    p2.FaceAlpha = 1;
    zticks((size(vert3d, 3)/2));
    zl = vertStruct(vert_idx).vert;
    zticklabels([zl]);
    xticks([]);
    yticks([]);
    view(3)
    daspect([1,1,1/3])
    axis tight
    ax = gca;
    ax.FontSize = 14;
    camlight
    camlight(-80,-10)
    lighting flat
    title("p1d3", 'FontSize', 14);

end