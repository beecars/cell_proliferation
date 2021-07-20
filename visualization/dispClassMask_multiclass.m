function fig = dispClassMask_multiclass(pd_idx, classes)
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
    fv0 = isosurface(construction_volume, 0.5);
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.4;

    xticks([]);
    yticks([]);
    zticks([]);
    view(3)
    daspect([1,1,1/5])
    axis tight
    camlight
    camlight(-80,-10)
    lighting flat
    title("\fontsize{14}p" + pd_idx(1) + "d" + pd_idx(2));

end