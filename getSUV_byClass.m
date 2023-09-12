function pct_gtr_14_arr = getSUV_byClass(pd_idx)
%GETTOTALSUV_BYCLASS extracts total SUV from associated mask and
%FLT-PET data by downsampling the mask data in the axial plane to
%match the FLT-PET data and aggregating the masked FLT-PET SUV values.
%Programmed to extract for the "spine", "pelvi", and "stern" volume
%mask variables, but can be edited for other object class names.

tSUV_spine = SUV_wrapper(pd_idx, 'spine');
tSUV_pelvi = SUV_wrapper(pd_idx, 'pelvi');
tSUV_stern = SUV_wrapper(pd_idx, 'stern');

SUV_struct.pd_idx = pd_idx;
SUV_struct.tSUV_spine = tSUV_spine;
SUV_struct.tSUV_pelvi = tSUV_pelvi;
SUV_struct.tSUV_stern = tSUV_stern;

end