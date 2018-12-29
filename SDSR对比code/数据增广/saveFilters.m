addpath('../../matlab/');
caffe.reset_all();
clear;close all;
folder = './';
my_model = [folder 'FastARCNN_mat.prototxt'];
my_weights = [folder 'FastARCNN_iter_5000000.caffemodel'];
framewidth = 8;
my_net = caffe.Net(my_model, my_weights, 'test');
M = 1;
N = M+4;
weights_conv = cell(N,1);
biases_conv = cell(N,1);
prelu_conv = cell(N,1);
cnt=0;
for idx = 1:2
    conv_filters = my_net.layers(['conv' num2str(idx)]).params(1).get_data();
    channel = size(conv_filters,3);
    filtersize = size(conv_filters,1);
    filternum = size(conv_filters,4);
    weights = single(ones(channel,filtersize^2, filternum));
    for i = 1 : channel
        for j = 1 : filternum
             temp = conv_filters(:,:,i,j);
             weights(i,:,j) = temp(:);
        end
    end
    cnt=cnt+1;
    weights_conv{cnt} = double(weights);
    biases_conv{cnt} = my_net.layers(['conv' num2str(idx)]).params(2).get_data();
    prelu_conv{cnt} = my_net.layers(['relu' num2str(idx)]).params(1).get_data();

    %plot_filterpattern(weights,filternum,channel,filtersize,framewidth);
end
for idx = 2:M +2
    conv_filters = my_net.layers(['conv2' num2str(idx)]).params(1).get_data();
    channel = size(conv_filters,3);
    filtersize = size(conv_filters,1);
    filternum = size(conv_filters,4);
    weights = single(ones(channel,filtersize^2, filternum));
    for i = 1 : channel
        for j = 1 : filternum
             temp = conv_filters(:,:,i,j);
             weights(i,:,j) = temp(:);
        end
    end
    cnt=cnt+1;
    weights_conv{cnt} = double(weights);
    biases_conv{cnt} = my_net.layers(['conv2' num2str(idx)]).params(2).get_data();
    prelu_conv{cnt} = my_net.layers(['relu2' num2str(idx)]).params(1).get_data();
   
    %plot_filterpattern(weights,filternum,channel,filtersize,framewidth);
end
for idx = 3
    conv_filters = my_net.layers(['conv' num2str(idx)]).params(1).get_data();
    channel = size(conv_filters,3);
    filtersize = size(conv_filters,1);
    filternum = size(conv_filters,4);
    weights = single(ones(channel,filtersize^2, filternum));
    for i = 1 : channel
        for j = 1 : filternum
             temp = conv_filters(:,:,i,j);
             weights(i,:,j) = temp(:);
        end
    end
    cnt=cnt+1;
    weights_conv{cnt} = double(weights);
    biases_conv{cnt} = my_net.layers(['conv' num2str(idx)]).params(2).get_data();
    %plot_filterpattern(weights,filternum,channel,filtersize,framewidth);
end
save([folder 'q10.mat'],'weights_conv','biases_conv','prelu_conv');
