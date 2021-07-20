This MATLAB project is for extracting and visualizing volume FLT-PET image
data from FLT-PET image volumes and associated masks. The subjects are stem 
cell transplant patients (HSCT). The objective is to individually segment
vertebral bodies, as well as other regions of interest. U-Net was used in 
a PyTorch implementation to predict segmentation masks. The vertebral body 
class output from the U-Net is the column of vertebral bodies, and here
I provide some functions that ingest the vertebral body column mask, along
with the FLT-PET data, and use these to output individually segmented 
vertebral bodies for the lumbar and thoracic vertebrae.

Features of this project:
F1. Volume segmentation and PET extraction visualization tools provided in 
    the "visualization" folder. PET visualizations use isosurfaces defined
    by programmatic analysis of the distribution of SUV values (or the PET
    voxel intensities). 
    - "dispVertPET_single.m": displays a single vertebral body
    - "dispVertPET_patient_readout.m": displays the entire column of 
      vertebral bodies and each vertebral body individually. 
    - "dispVertPET_instances.m": displays the entire column of vertebral 
      body instances.
    - "dispVertMask_instances.m": displays instance segmentations of the 
      entire column of vertebral body masks without PET data. 
    - "dispClassMask_multiclass.m": displays any number of masks from a list 
      of object classes passed to the function. 
    - "dispClassPET_multiclass.m": displays any number of extracted PET 
      volumes from a list of object classes passed to the function. 
F2. Instance segmentaiton of vertebral bodies provided by the
    "createVertStruct" function. 
    - "createVertStruct.m": performns the instance segmentation. Requires
      a very specific PET data volume from the FLT radiotracer. Read rest
      of REAMDE for more details, or look at source file. 
F3. FLT-PET SUV extraction. Extracts total SUV content of a volume
    segmentation. 
    - "getTotalSUV_byClass.m": extracts total SUV from associated mask and
      FLT-PET data by downsampling the mask data in the axial plane to
      match the FLT-PET data and aggregating the masked FLT-PET SUV values. 
      Programmed to extract for the "spine", "pelvi", and "stern" volume
      mask variables, but can be edited for other object class names. 
    - "totalSUV_wrapper.m": a wrapper for calculating total SUV from a 
      given object class name (string) and a pd_idx [patient_idx, day_idx] 
      associated with a "ct_pt_matfile" and a "mask_matfile" described 
      further below in this README.
    - "totalSUV_dilateAxialPlane.m": function used with "createVertStruct"
      to produce total SUV content alongside the other struct fields for the
      individually segmented vertebrae. 

There are some assumptions made for this project. Since I had a very specific
dataset, I used some code "shortcuts" that may not generalize well to other 
datasets. 

A0. FLT-PET and CT/mask data is pre-registered in the axial plane, but not
    necessarily along the axial direction. 
A1. Segmentation masks are derived from CT data and have the same dimensions. 
A2. Mask volumes are higher resolution than PET volumes in the axial plane.
A3. PET resolution is higher than CT/mask resolution along the axial direction.
A4. For vertebral body instance segmentation functions, or those relying on 
    "createVertStruct", the FLT-PET must be from around 25+ days post HSCT. 
A5. Volumes are undersampled by approximately 3x along the axial direction.
    The functions will work with data sampled at different rates along
    the axial direction, but the visualizations are programmed to "stretch"
    by a factor of 3, so you would want to change that function or add
    an argument to adjust the aspect ratio. 

Most of the top-level fucntions assume some specific data structures on the 
MATLAB path. These data structures are ".mat" files with the following 
specifications:

D1. A "ct_pt_matfile" of the naming convention "patient#_day#.mat" where # 
    refers to patient and scan indexes. In my dataset patients are scanned
    on multiple days. In my dataset the axial plane resolution in the CT
    scan volumes (and therefore the mask volumes) is much greater than that
    of the PET volumes. For visualization, PET is up-sampled to the CT 
    dimensions in the axial plane. For SUV extraction, the masks are 
    downsampled in the axial plane from the CT dimensions to the PET 
    dimensions. This MATLAB project assumes mask volumes are higher
    resolution than PET volumes. 
   
    The matfile must contain the following variables:
        ct - CT volume data.
        ct_info - CT metadata struct with fields "SliceThickness" and 
                  "SliceLocation".
        pt - PET volume data (in units of SUV, if using SUV extraction).
        pt_info - PET metadata struct with fields "SliceThickness" and 
                  "SliceLocation".
        * "SliceLocation is the global z-coordinate of the scanning system.
          The functions assume the pt and ct slice locations start and 
          end at approximately the same global coordinates, which is 
          required for a "check" to see if the pt and ct slice coordinates
          are inverted, which they sometimes are in my dataset. 
        * "SliceThickness" is the interval between scans and is used for
          interpolation.

    The volume data above should be oriented thusly:
        X (1st) axis - coronal plane direction.
        Y (2nd) axis - sagittal plane direction.
        Z (3rd) axis - axial plane direction.

D2. A "mask_matfile" of the naming convention "patient#_day#_pred.mat"
    corresponding to the "ct_pt_matfile" of 1. This matfile contains the
    binary mask columes of the ROIs stored as variables. The visualization
    tool "dispClassMask_multiclass" and "dispClassPET_multiclass" that are
    provided in the "visualization" folder can be used with any variable
    name or custom ROI. "The dispVertPET_*" requires a binary mask volume 
    with variable name "spine" (and associated PET data that meets 
    assumption A3 and A4). 

    The volume data above should be oriented thusly:
        X (1st) axis - coronal plane direction.
        Y (2nd) axis - sagittal plane direction.
        Z (3rd) axis - axial plane direction.