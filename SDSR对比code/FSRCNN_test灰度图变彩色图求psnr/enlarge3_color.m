% =========================================================================
% Test code for Fast Super-Resolution Convolutional Neural Networks (FSRCNN)
%
% Reference
%   Chao Dong, Chen Change Loy, Xiaoou Tang. Accelerating the Super-Resolution Convolutional Neural Networks, 
%   in Proceedings of European Conference on Computer Vision (ECCV), 2016
%
% Chao Dong
% SenseTime Group
% For any question, send email to chaodong@sensetime.com
% =========================================================================
close all;
clear all;

%% set parameters
testfolder = 'test\Set14\';
up_scale = 3;
model = 'model\FSRCNN\x3.mat';

filepaths = dir(fullfile(testfolder,'*.bmp'));
%psnr_bic = zeros(length(filepaths),1);
%psnr_fsrcnn = zeros(length(filepaths),1);

%for i = 1 : length(filepaths)
   
    %% read ground truth image
     %[add,imname,type] = fileparts(filepaths(i).name);
    % im = imread([testfolder imname type]);
     img=single(imread('D:\CNN\SRCNN\2016FSRCNN\FSRCNN_test\FSRCNN_test\123.png'));

   
   %% work on illuminance only
% if size(im,3)>1
%     img = rgb2ycbcr(im);
%     im = img(:, :, 1);
% end
% im2 = img(:, :, 2);
% im3 = img(:, :, 3);
% im2= modcrop(im2, up_scale);
% im2 = single(im2)/255;
% im3= modcrop(im3, up_scale);
% im3 = single(im3)/255;
% 
% 
% %im_gnd = modcrop(im, up_scale);
% %im_gnd = single(im_gnd)/255;
% 
% %% bicubic interpolation
% im2_l = imresize(im2, 1/up_scale, 'bicubic');
% im2_b = imresize(im2_l, up_scale, 'bicubic');
% im3_l = imresize(im3, 1/up_scale, 'bicubic');
% im3_b = imresize(im3_l, up_scale, 'bicubic');
% 
% 
% im_l = imresize(im_gnd, 1/up_scale, 'bicubic');
% im_b = imresize(im_l, up_scale, 'bicubic');
imh_cb  = imresize(img(:, :, 2), up_scale, 'bicubic');
imh_cr  = imresize(img(:, :, 3), up_scale, 'bicubic');
    %% FSRCNN
    imh_y = FSRCNN(model, img(:, :, 1), up_scale);
%     imh_cb  = FSRCNN(model, img(:, :, 2), up_scale);
%     imh_cr = FSRCNN(model, img(:, :, 3), up_scale);
    

%% remove border
% im_h = shave(uint8(im_h * 255), [up_scale, up_scale]);
% im_gnd = shave(uint8(im_gnd * 255), [up_scale, up_scale]);
% 
% im2_b = shave(uint8(im2_b * 255), [up_scale, up_scale]);
% im3_b = shave(uint8(im3_b * 255), [up_scale, up_scale]);
% im_b = shave(uint8(im_b * 255), [up_scale, up_scale]);
%% ycbcr2rgb
% psnr_bic = compute_psnr(im_gnd,im_b);
% psnr_srcnn = compute_psnr(im_gnd,im_h);
%%SRCNN
% imh_y = shave(uint8(imh_y * 255), [up_scale, up_scale]);
% imh_cb = shave(uint8(imh_cb * 255), [up_scale, up_scale]);
% imh_cr = shave(uint8(imh_cr * 255), [up_scale, up_scale]);
% 

[m,n]=size(imh_y);
imh=single(zeros(m,n,3));
imh(:,:,1)=imh_y;
imh(:,:,2)=imh_cb;
imh(:,:,3)=imh_cr;
% figure,
% imshow(imh_y,[]);
% figure,
% imshow(imh_cb,[]);
% figure,
% imshow(imh_cr,[]);

imh_rgb=ycbcr2rgb(uint8(imh));
%%BICUBIC
% im_h3=zeros(m,n,3);
% im_h3(:,:,1)=im_b;
% im_h3(:,:,2)=im2_b;
% im_h3(:,:,3)=im3_b;

% im_h4=ycbcr2rgb(uint8(im_h3));

%% compute PSNR
% psnr_bic = compute_psnr(im_gnd,im_b);
% psnr_srcnn = compute_psnr(im_gnd,im_h);

%% show results
% fprintf('PSNR for Bicubic Interpolation: %f dB\n', psnr_bic);
% fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);
% 
% figure, imshow(im_b); title('Bicubic Interpolation');
% figure, imshow(im_h4); title('Bicubic Reconstruction');
% figure, imshow(im_h); title('SRCNN Reconstruction');
figure, imshow(imh_rgb,[]); title('imh_rgb Reconstruction');

%imwrite(im_b, ['Bicubic Interpolation' '.bmp']);
imwrite(imh_rgb, ['imh_rgb' '.bmp']);
% imwrite(im_h4, ['biccomic2' '.bmp']);
  
  imh3  = uint8(imresize(img, up_scale, 'bicubic')); 
  imwrite(imh3, ['imh3' '.bmp']);
     
     
     
     
     
     
   