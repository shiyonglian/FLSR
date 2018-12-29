function im_h = FSRCNN(model, im_l, up_scale)

%% load CNN model parameters
load(model);
[hei,wid] = size(im_l);
outhei = hei * up_scale;
outwid = wid * up_scale;
layer_num = length(weights_conv);
conv_data = cell(layer_num,1);

%% conv1
weight = weights_conv{1};
bias = biases_conv{1};
[channel, filtersize, filters] = size(weight);
patchsize = sqrt(filtersize);
weight = reshape(weight, patchsize, patchsize, filters);
data_tmp = zeros(hei, wid, filters);
for i = 1 : filters 
    data_tmp(:,:,i) = imfilter(im_l, weight(:,:,i), 'same','replicate');
    data_tmp(:,:,i) = max(data_tmp(:,:,i) + bias(i), 0) + prelu_conv{1} * min(data_tmp(:,:,i) + bias(i),0);
end
conv_data{1} = data_tmp;

%% conv2+
for idx = 2 : layer_num-1
    weight = weights_conv{idx};
    bias = biases_conv{idx};
    [channel, filtersize, filters] = size(weight);
    patchsize = sqrt(filtersize);
    data_tmp = zeros(hei, wid, filters);
    data_pre = conv_data{idx-1};
    for i = 1 : filters
        for j = 1 : channel
            subfilter = reshape(weight(j,:,i), patchsize, patchsize);
            data_tmp(:,:,i) = data_tmp(:,:,i) + imfilter(data_pre(:,:,j), subfilter, 'same', 'replicate');
        end
        data_tmp(:,:,i) = max(data_tmp(:,:,i) + bias(i),0) + prelu_conv{idx} * min(data_tmp(:,:,i) + bias(i),0);
    end
    conv_data{idx} = data_tmp;
end

%% conv3
weight = weights_conv{layer_num};
bias = biases_conv{layer_num};
[filters, filtersize,channel] = size(weight);
temp = zeros(channel,filtersize);
for i = 1 : channel
        temp(i,:) = weight(1,:,i);
end
weight = temp;
[channel, filtersize, filters] = size(weight);
patchsize = sqrt(filtersize);

conv3_data = zeros(outhei,outwid);
conv2_data = conv_data{layer_num-1};
for j = 1 : channel
    subfilter = reshape(weight(j,:), patchsize, patchsize);
    conv3_data(:,:)=conv3_data(:,:) + deconv(conv2_data(:,:,j), subfilter, up_scale);
end
im_h = conv3_data(:,:) + bias(1);


