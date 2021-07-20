function idx = getClosestValueIdx(array, value)
%GETCLOSESTVALUEIDX Returns the index of the value in an array that is
%closest to a given value. 
diff_array = abs(array - value);
[~,idx] = min(diff_array);
end

