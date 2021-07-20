function fig = createFigureForPatientPET(pd_idx)
%CREATEFIGUREFORPATIENTPET Summary of this function goes here
%   Detailed explanation goes here

[vertStruct, vertIdxs] = createVertStruct(pd_idx);

figure();
set(0,'DefaultTextFontname', 'LM Sans 12')
set(0,'DefaultAxesFontName', 'LM Sans 12')
sgtitle("FLT-PET SUV Isosurfaces D+28" + newline + "Patient#" + pd_idx(1), 'FontSize', 18)

h(1) = subplot(6, 4, [1, 5, 9, 13, 17, 21]);
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(1).pt_data, zs, ...
                    vertStruct(2).pt_data, zs, ...
                    vertStruct(3).pt_data, zs, ...
                    vertStruct(4).pt_data, zs, ...
                    vertStruct(5).pt_data, zs, ...
                    vertStruct(6).pt_data, zs, ...
                    vertStruct(7).pt_data, zs, ...
                    vertStruct(8).pt_data, zs, ...
                    vertStruct(9).pt_data, zs, ...
                    vertStruct(10).pt_data, zs, ...
                    vertStruct(11).pt_data, zs, ...
                    vertStruct(12).pt_data, zs, ...
                    vertStruct(13).pt_data, zs, ...
                    vertStruct(14).pt_data, zs, ...
                    vertStruct(15).pt_data, zs, ...
                    vertStruct(16).pt_data, zs, ...
                    vertStruct(17).pt_data, zs);
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
fv0 = isosurface(vert3d, 0.0001);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
colormap("lines");
p0 = patch(fv0,'FaceColor', 'black','EdgeColor','none');
p0.FaceAlpha = 0.05;
p1 = patch(fv1,'FaceColor', 'yellow','EdgeColor','none');
p1.FaceAlpha = 0.2;
p2 = patch(fv2,'FaceColor', 'red','EdgeColor','none');
p2.FaceAlpha = 0.3;
p2 = patch(fv3,'FaceColor', 'black','EdgeColor','none');
p2.FaceAlpha = 1;
[zt, zl] = getVertTickLabels(vertIdxs);
zticks(zt);
zticklabels(zl);
xticks([]);
yticks([]);
view(90, 0);
daspect([1,1,1/3]);
axis tight;
camlight;
camlight(-80,-10);
lighting flat;

h(2) = subplot(6, 4, 2);
vidx = 1;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3]);
axis tight;
ax = gca;
ax.FontSize = 14;
camlight;
camlight(-80,-10);
lighting flat;

h(3) = subplot(6, 4, 3);
vidx = 2;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(4) = subplot(6, 4, 4);
vidx = 3;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(5) = subplot(6, 4, 6);
vidx = 4;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(6) = subplot(6, 4, 7);
vidx = 5;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(7) = subplot(6, 4, 8);
vidx = 6;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(8) = subplot(6, 4, 10);
vidx = 7;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(9) = subplot(6, 4, 11);
vidx = 8;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(10) = subplot(6, 4, 12);
vidx = 9;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(11) = subplot(6, 4, 14);
vidx = 10;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(12) = subplot(6, 4, 15);
vidx = 11;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(13) = subplot(6, 4, 16);
vidx = 12;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(14) = subplot(6, 4, 18);
vidx = 13;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(15) = subplot(6, 4, 19);
vidx = 14;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(16) = subplot(6, 4, 20);
vidx = 15;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(17) = subplot(6, 4, 22);
vidx = 16;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat

h(18) = subplot(6, 4, 23);
vidx = 17;
zs = zeros(512);
vert3d = cat(3, zs, vertStruct(vidx).pt_data, zs);
fv0 = isosurface(vert3d, 0.5);
fv1 = isosurface(vert3d, iso_val_1);
fv2 = isosurface(vert3d, iso_val_2);
fv3 = isosurface(vert3d, iso_val_3);
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
zl = vertStruct(vidx).vert;
zticklabels([zl]);
xticks([]);
yticks([]);
view(-35,10);
daspect([1,1,1/3])
axis tight
ax = gca;
ax.FontSize = 14;
camlight
camlight(-80,-10)
lighting flat
set(gcf,'color','w');
fig = gcf;

set(gcf,'Position',[277,126,1271,1128])



end

