function bounds = getNonZeroBounds3D(data3d)
%GETNONZEROBOUNDS3D Finds the bounds of a segmentation mask or segmented
% data. To be used to remove "zero pading" from segmentations.
%   Input: 3d volume
%   Returns: [xlbound, xrbound;
%             ylbound, yrbound;
%             zlbound, zrbound]

for slice = 1:size(data3d, 1)
    if nnz(data3d(slice, :, :)) == 0
        continue
    else
        xlbound = slice;
        break
    end
end
% find xdim right bound
for slice = fliplr(1:size(data3d, 1))
    if nnz(data3d(slice, :, :)) == 0
        continue
    else
        xrbound = slice;
        break
    end
end
% find ydim left bound
for slice = 1:size(data3d, 2)
    if nnz(data3d(:, slice, :)) == 0
        continue
    else
        ylbound = slice;
        break
    end
end
% find ydim right bound
for slice = fliplr(1:size(data3d, 2))
    if nnz(data3d(:, slice, :)) == 0
        continue
    else
        yrbound = slice;
        break
    end
end
% find zdim left bound
for slice = 1:size(data3d, 3)
    if nnz(data3d(:, :, slice)) == 0
        continue
    else
        zlbound = slice;
        break
    end
end
% find zdim right bound
for slice = fliplr(1:size(data3d, 3))
    if nnz(data3d(:, :, slice)) == 0
        continue
    else
        zrbound = slice;
        break
    end
end

bounds = [xlbound, xrbound; ylbound, yrbound; zlbound, zrbound];

end

