function alignedPETvolume = maximizePETinMask(pt_vol, mask_vol, step)
%MAXIMIZEPETINMASK Performs an optimization to maximize the PET response in the
% given mask. Basically a fine registration procedure.

bl_pt_vol = pt_vol;
bl = meanSUV_calculate(pt_vol, mask_vol);

% maximize dim 1
test_pt_vol = imtranslate(pt_vol, [step, 0, 0]);
if meanSUV_calculate(test_pt_vol, mask_vol) > bl
    dir = 1;
else
    dir = -1;
end
dim1_adjust = 0;
dim1_optimized = 0;
bestSUV1 = bl;
while dim1_optimized == 0
    dim1_adjust = dim1_adjust + step*dir;
    pt_vol = imtranslate(pt_vol, [step*dir, 0, 0]);
    new_meanSUV = meanSUV_calculate(pt_vol, mask_vol);
    if  new_meanSUV > bestSUV1
        bestSUV1 = new_meanSUV;
        continue
    else
        dim1_adjust = dim1_adjust - step*dir;
        dim1_optimized = 1;
    end
end

% maximize dim 2
test_pt_vol = imtranslate(pt_vol, [0, step, 0]);
if meanSUV_calculate(test_pt_vol, mask_vol) > bl
    dir = 1;
else
    dir = -1;
end
dim2_adjust = 0;
dim2_optimized = 0;
bestSUV2 = bl;
pt_vol = bl_pt_vol;
while dim2_optimized == 0
    dim2_adjust = dim2_adjust + step*dir;
    pt_vol = imtranslate(pt_vol, [0, step*dir, 0]);
    new_meanSUV = meanSUV_calculate(pt_vol, mask_vol);
    if  new_meanSUV > bestSUV2
        bestSUV2 = new_meanSUV;
        continue
    else
        dim2_adjust = dim2_adjust - step*dir;
        dim2_optimized = 1;
    end
end


alignedPETvolume = imtranslate(bl_pt_vol, [dim1_adjust, dim2_adjust, 0]);
end

