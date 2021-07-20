function nzidx = getFirstNonZeroIdx(array)
%GETFIRSTNONZEROIDX Finds the first nonzero index in a 1D array.
for idx = 1:length(array)
    if array(idx) == 0
        continue
    else
        nzidx = idx;
        break
    end
end

