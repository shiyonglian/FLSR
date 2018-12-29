# FLSR
MATLAB是做FLSR实验的所有matlab代码；
1）MATLAB中包含两个文件MATLAB1中有
drawpsnr+.m是使用自相似性的测试方法代码，
enlargedata.m是数据增强代码，增强40倍，4（旋转）*2（镜像和原图）*5（1 0.9 0.8 0.7 0.6）；
drawpsnr.m是正常的测试psnr、ssim的代码；
其余还有数据集的制作HDFS文件的制作（包括切块、lable的制作等）generate.m文件就是数据集制作代码；
另一个文件夹是IDN中的函数，因为在drawpsnr.m中添加了测试重建时间time，结构保真度IFC的代码这些都是参考IDN做的增加实验，所以嵌入了它的代码；
2）SDSR对比code是SDSR实验中使用到的所有MATLAB代码
其中每个文件夹中都有文件功能说明，包括超分图像的局部放大代码、数据增强代码（20倍）、多个结构的曲线对比图、HDFS数据的制作
