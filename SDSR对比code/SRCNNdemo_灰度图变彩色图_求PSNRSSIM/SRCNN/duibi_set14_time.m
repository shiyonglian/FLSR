% =========================================================================
% Test code for Super-Resolution Convolutional Neural Networks (SRCNN)
%
% Reference
%   Chao Dong, Chen Change Loy, Kaiming He, Xiaoou Tang. Learning a Deep Convolutional Network for Image Super-Resolution, 
%   in Proceedings of European Conference on Computer Vision (ECCV), 2014
%
%   Chao Dong, Chen Change Loy, Kaiming He, Xiaoou Tang. Image Super-Resolution Using Deep Convolutional Networks,
%   arXiv:1501.00092
%
% Chao Dong
% IE Department, The Chinese University of Hong Kong
% For any question, send email to ndc.forward@gmail.com
% =========================================================================
close all;
clear all;
%% read ground truth image
%% settings
folder = 'Set14'
filepaths = dir(fullfile(folder,'*.bmp'));
up_scale = 3;
psnr=zeros(1,length(filepaths));
sum=0;
tic
for i = 1 : length(filepaths)
     im = imread(fullfile(folder,filepaths(i).name));
     if size(im,3)>1
    im = rgb2ycbcr(im);
    im = im(:, :, 1);
     end
    im = im2double(im);
    
    im_gnd = modcrop(im, up_scale);
    [hei,wid] = size(im_gnd);
    im_input = imresize(imresize(im_gnd,1/up_scale,'bicubic'),[hei,wid],'bicubic');%输入输出同等大小


%% set parameters
up_scale = 3;
model = 'model\9-1-5(ImageNet)\x3.mat';
load(model);
% up_scale = 3;
% model = 'model\9-3-5(ImageNet)\x3.mat';
% up_scale = 3;
% model = 'model\9-1-5(91 images)\x3.mat';
% up_scale = 2;
% model = 'model\9-5-5(ImageNet)\x2.mat'; 
% up_scale = 4;
% model = 'model\9-5-5(ImageNet)\x4.mat';

%% SRCNN
im_h = SRCNN(model, im_input);

%% remove borderz移除边界？？
im_h1 = shave(uint8(im_h * 255), [up_scale, up_scale]);
im_gnd = shave(uint8(im_gnd * 255), [up_scale, up_scale]);
im_input = shave(uint8(im_input * 255), [up_scale, up_scale]);

%% compute PSNR
psnr_bic = compute_psnr(im_gnd,im_input);
psnr_srcnn = compute_psnr(im_gnd,im_h1);
psnr(i)=psnr_srcnn;
sum=sum+psnr_srcnn;

%% show results
fprintf('PSNR for Bicubic Interpolation: %f dB\n', psnr_bic);
fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);
imwrite(im_b, ['Bicubic Interpolation' num2str(i),'.bmp']);
imwrite(im_h, ['SRCNN Reconstruction' num2str(i),'.bmp']);

figure, imshow(im_input); title('Bicubic Interpolation');
figure, imshow(im_h1); title('SRCNN Reconstruction');
end 
average_psnr=sum/length(filepaths)
toc
%imwrite(im_b, ['Bicubic Interpolation' '.bmp']);
%imwrite(im_h, ['SRCNN Reconstruction' '.bmp']);
