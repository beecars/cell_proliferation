function [vert_ticks, vert_labels] = getVertTickLabels(vertIdxs)
%GETVERTTICKLABELS Used exclusively for making figures with nice vertebrae
%labels. 
%   Uses vertIdxs from the createVertStruct function to positionally
%determine where to put each label on the axis of a chart. 
%
% Input: vertIdxs (from createVertStruct)
% Returns: vert_ticks - positional axis coordinates
%          vert_labels - string axis labels
vert_labels = {'L5', 'L4', 'L3', 'L2', 'L1', 'T12', 'T11', 'T10', 'T9', ...
               'T8', 'T7', 'T6', 'T5', 'T4', 'T3', 'T2', 'T1', 'C7', 'C6', ...
               'C5', 'C4', 'C3', 'C2'};
nvi = vertIdxs - min(vertIdxs);
vert_ticks = zeros(length(vert_labels), 1);
for idx = 1:length(vert_ticks)
    vert_ticks(idx) = (nvi(idx) + nvi(idx+1)) / 2;
end

