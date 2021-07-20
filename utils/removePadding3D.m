function newVolume = removePadding3D(volume)
%REMOVEPADDING Removes padding from the 3D volume
bounds = getNonZeroBounds3D(volume);
newVolume = volume(bounds(1,1):bounds(1,2), ...
                   bounds(2,1):bounds(2,2), ...
                   bounds(3,1):bounds(3,2));
end

