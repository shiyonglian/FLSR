
***********************************************************************************************************
***********************************************************************************************************

Matlab demo code for "Accelerating the Super-Resolution Convolutional Neural Networks" (ECCV 2016) 

by Chao Dong (dongchao@sensetime.com)

If you use/adapt our code in your work (either as a stand-alone tool or as a component of any algorithm),
you need to appropriately cite our ECCV 2016 paper.

This code is for academic purpose only. Not for commercial/industrial activities.


NOTE:

  The running time reported in the paper is from c++ implementation. This Matlab version is a re-
implementation, and is for the ease of understanding the algorithm. This code is not optimized, and the 
speed is not representative. The result can be slightly different from the paper due to transferring
across platforms.


***********************************************************************************************************
***********************************************************************************************************


Usage:

demo_FSRCNN.m - demonstrate super-resolution using FSRCNN.m

function:

FSRCNN.m - realize super resolution given the model parameters

Folders:

test - test images Set5 and Set14.

model/FSRCNN - model parameters of FSRCNN(56,12,4) trained on general-100 and 91-image datasets. "x2.mat" "x3.mat" and "x4.mat" are model parameters used for upscaling factors 2,3 and 4 seperately.

model/FSRCNN-s - model parameters of FSRCNN-s (the small version FSRCNN(32,5,1)) trained on general-100 and 91-image datasets.
