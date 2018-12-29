 clc;clear;close all;
 time1=[0.25 0.75 0.83 0.9 1.5 3.2 5.7];
 psnr=[29.5 28.65 29.1 29 28.9 29.2 29.1];
 axis([0.1 10 28.5 30]);%设置坐标轴在指定的范围内
semilogx(time1, psnr,'.');grid on
xlabel('slow              Run Time(s)           fast');
ylabel('PSNR(dB)')