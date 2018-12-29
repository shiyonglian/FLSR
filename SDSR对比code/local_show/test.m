clc;clear
close all;
im1     = imread('C:\Users\fan\Desktop\gan测试图\lenna_bicubic.png');
bbox1   = [170,50,40,40]; % 设置显示区域
%im_loc1 = loc_show(im1,bbox1);
im=im1;
bbox=bbox1;
%% 图像局部放大并显示矩形框
% Zebin Chen
% ZB302 ZHBIT
% March 20，2017
%

%% 在图像中局部显示矩形框
% X    = 120; %矩形框左上角的横坐标   
% Y    = 60; %矩形框左上角的纵坐标
% dX   = 30;    
% dY   = 30;  
% bbox = [X, Y, dX, dY];
im_1 = insertShape(im, 'Rectangle', bbox, 'LineWidth', 2, ...
    'Color', 'green');

%% 裁剪和局部并插值放大
scale     = 3;
im_crop   = imcrop(im, bbox); 
im_crop_b = imresize(im_crop, scale, 'bicubic'); 

%% 局部显示
[row_1, col_1, ~]                         = size(im);
[row_2, col_2, ~]                         = size(im_crop_b);
im_loc                                  = im_1;
im_loc(row_1-row_2+1:col_1, 1:col_2, :) = im_crop_b;
bbox  = [1,row_1-row_2+1,col_2,row_2];
im_loc  = insertShape(im_loc, 'Rectangle', bbox, 'LineWidth', 1, ...
    'Color', 'w');



figure;imshow(im_loc);
imwrite(im_loc, ['lenna_bicubic_localshow' '.bmp']);


%im2     = imread('baby_GT.bmp');
%bbox2   = [140,170,50,50]; % 设置显示区域
%im_loc2 = loc_show(im2,bbox2);
%figure;imshow(im_loc2);
%imwrite(im_loc2, ['2' '.bmp']);