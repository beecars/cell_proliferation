function mask_volume = extractLargestComponent3D(mask_volume)
%EXTRACTLARGESTCOMPONENT3D From an input volume mask, extracts the largest
%connected component and returns it in the same sized volume as the input. 

cc = bwconncomp(mask_volume, 6);
numVoxels = cellfun(@numel, cc.PixelIdxList);
[~, big_idx] = max(numVoxels);
for idx = 1:length(numVoxels)
    if idx ~= big_idx
        mask_volume(cc.PixelIdxList{idx}) = 0;
    end
end
end

