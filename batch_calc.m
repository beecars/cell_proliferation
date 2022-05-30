pd_idxs = [[1, 3];[2,3];[3,3];[4,3];[5,3];[6,3];[7,3];[8,3];[9,3];[10,3];[11,3];[12,2];[13,3];[14,3];[15,3];[16,3];[17,3];[18,3];[19,3];[20,3];[21,3];[22,3]]

pelvi_stats = struct('meanSUV', [], 'medianSUV', [], 'maxSUV', [], 'stdSUV', []);
stern_stats = struct('meanSUV', [], 'medianSUV', [], 'maxSUV', [], 'stdSUV', []);
for i = 1:length(pd_idxs)
    pd_idx = pd_idxs(i,:);
    pelvi_stats(i) = SUV_wrapper(pd_idx, "pelvi");
    stern_stats(i) = SUV_wrapper(pd_idx, "stern");
    
end