function fig = dispClassPET_multiclass_14(pd_idx, classes)
    fig = figure();
    subplot(1,3,1);
    mask_matfile = "patient" + pd_idx(1) + "_day" + 1 + "_pred.mat";
    ct_pt_matfile = "patient" + pd_idx(1) + "_day" + 1 + ".mat";
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

    color = 'magenta';
    iso_val_1 = 0.5;
%     iso_val_2 = 1.0;
%     iso_val_3 = 1.4;
%     iso_val_4 = 3.0;
%     iso_val_5 = 7.0;
    fv0 = isosurface(pt_masked, 0.0001);
    fv1 = isosurface(pt_masked, iso_val_1);
%     fv2 = isosurface(pt_masked, iso_val_2);
%     fv3 = isosurface(pt_masked, iso_val_3);
%     fv4 = isosurface(pt_masked, iso_val_4);
%     fv5 = isosurface(pt_masked, iso_val_5);
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.05;
    p1 = patch(fv1,'FaceColor', color,'EdgeColor','none');
    p1.FaceAlpha = 0.5;
%     p2 = patch(fv2,'FaceColor', 'blue','EdgeColor','none');
%     p2.FaceAlpha = 0.1;
%     p3 = patch(fv3,'FaceColor', 'green','EdgeColor','none');
%     p3.FaceAlpha = 0.2;
%     p4 = patch(fv4,'FaceColor', 'yellow','EdgeColor','none');
%     p4.FaceAlpha = 0.2;
%     p5 = patch(fv5,'FaceColor', 'red','EdgeColor','none');
%     p5.FaceAlpha = 0.2;
    xticks([]);
    yticks([]);
    zticks([]);
    view(3)
    daspect([1,1,1/3])
    axis tight
    camlight
    camlight(-80,-10)
    lighting flat
    title("\fontsize{14}p" + pd_idx(1) + "d" + 1);
    



    subplot(1,3,2);
    mask_matfile = "patient" + pd_idx(1) + "_day" + 2 + "_pred.mat";
    ct_pt_matfile = "patient" + pd_idx(1) + "_day" + 2 + ".mat";
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

    fv0 = isosurface(pt_masked, 0.0001);
    fv1 = isosurface(pt_masked, iso_val_1);
%     fv2 = isosurface(pt_masked, iso_val_2);
%     fv3 = isosurface(pt_masked, iso_val_3);
%     fv4 = isosurface(pt_masked, iso_val_4);
%     fv5 = isosurface(pt_masked, iso_val_5);
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.05;
    p1 = patch(fv1,'FaceColor', color,'EdgeColor','none');
    p1.FaceAlpha = 0.5;
%     p2 = patch(fv2,'FaceColor', 'blue','EdgeColor','none');
%     p2.FaceAlpha = 0.1;
%     p3 = patch(fv3,'FaceColor', 'green','EdgeColor','none');
%     p3.FaceAlpha = 0.2;
%     p4 = patch(fv4,'FaceColor', 'yellow','EdgeColor','none');
%     p4.FaceAlpha = 0.2;
%     p5 = patch(fv5,'FaceColor', 'red','EdgeColor','none');
%     p5.FaceAlpha = 0.2;
    xticks([]);
    yticks([]);
    zticks([]);
    view(3)
    daspect([1,1,1/3])
    axis tight
    camlight
    camlight(-80,-10)
    lighting flat
    title("\fontsize{14}p" + pd_idx(1) + "d" + 2);




    subplot(1,3,3);
    mask_matfile = "patient" + pd_idx(1) + "_day" + 3 + "_pred.mat";
    ct_pt_matfile = "patient" + pd_idx(1) + "_day" + 3 + ".mat";
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

    fv0 = isosurface(pt_masked, 0.0001);
    fv1 = isosurface(pt_masked, iso_val_1);
%     fv2 = isosurface(pt_masked, iso_val_2);
%     fv3 = isosurface(pt_masked, iso_val_3);
%     fv4 = isosurface(pt_masked, iso_val_4);
%     fv5 = isosurface(pt_masked, iso_val_5);
    p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
    p0.FaceAlpha = 0.05;
    p1 = patch(fv1,'FaceColor', color,'EdgeColor','none');
    p1.FaceAlpha = 0.5;
%     p2 = patch(fv2,'FaceColor', 'blue','EdgeColor','none');
%     p2.FaceAlpha = 0.1;
%     p3 = patch(fv3,'FaceColor', 'green','EdgeColor','none');
%     p3.FaceAlpha = 0.2;
%     p4 = patch(fv4,'FaceColor', 'yellow','EdgeColor','none');
%     p4.FaceAlpha = 0.2;
%     p5 = patch(fv5,'FaceColor', 'red','EdgeColor','none');
%     p5.FaceAlpha = 0.2;
    xticks([]);
    yticks([]);
    zticks([]);
    view(3)
    daspect([1,1,1/3])
    axis tight
    camlight
    camlight(-80,-10)
    lighting flat
    title("\fontsize{14}p" + pd_idx(1) + "d" + 3);
end