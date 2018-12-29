%% 图像局部放大并显示矩形框
% Zebin Chen
% ZB302 ZHBIT
% March 20，2017
%
%%
clc;clear;
close all;
im = imread('baby_GT.bmp');

%% 在图像中局部显示矩形框
X    = 120; %矩形框左上角的横坐标   
Y    = 60; %矩形框左上角的纵坐标
dX   = 80;    
dY   = 80;  
bbox = [X, Y, dX, dY];
im_1 = insertShape(im, 'Rectangle', bbox, 'LineWidth', 2, ...
    'Color', 'green');

%% 裁剪和局部并插值放大
scale     = 3;
im_crop   = imcrop(im, bbox); 
im_crop_b = imresize(im_crop, scale, 'bicubic'); 

%% 局部显示
[row_1, col_1, ~]                     = size(im);
[row_2, col_2, ~]                     = size(im_crop_b);
im_2                                  = im_1;
im_2(row_1-row_2+1:col_1, 1:col_2, :) = im_crop_b;
bbox  = [1,row_1-row_2+1,col_2,row_2];
im_2  = insertShape(im_2, 'Rectangle', bbox, 'LineWidth', 1, ...
    'Color', 'w');
figure;imshow(im_2);
imwrite(im_2,'baby_GT_local_show.bmp');






