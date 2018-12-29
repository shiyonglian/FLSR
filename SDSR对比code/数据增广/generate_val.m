clear;close all;
%% settings
folder = 'Val';
savepath = 'val.h5';
size_input = 24;
size_label = 23; 
JPEG_Quality = 10;
stride = 24;

%% initialization
data = zeros(size_input, size_input, 1, 1);
label = zeros(size_label, size_label, 1, 1);
%padding = abs(size_input - size_label)/2;
count = 0;

%% generate data
filepaths = dir(fullfile(folder,'*.jpg'));
    
for i = 1 : length(filepaths)
    
    image = imread(fullfile(folder,filepaths(i).name));
    if size(image,3)>1
        image = rgb2ycbcr(image);
    end
    imwrite(image(:,:,1),'im_JPEG.jpg','jpg','Quality',JPEG_Quality);
    im_input = im2double(imread('im_JPEG.jpg'));
    
    im_label = im2double(image(:, :, 1));
    [hei,wid] = size(im_label);
    
    for x = 1 : stride : hei-size_input+1
        for y = 1 :stride : wid-size_input+1
            
            subim_input = im_input(x : x+size_input-1, y : y+size_input-1);
            subim_label = im_label(x : x+size_label-1, y : y+size_label-1);

            count=count+1;
            data(:, :, 1, count) = subim_input;
            label(:, :, 1, count) = subim_label;
        end
    end
end

order = randperm(count);
data = data(:, :, 1, order);
label = label(:, :, 1, order); 

%% writing to HDF5
chunksz = 16;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,1,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,1,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
h5disp(savepath);
