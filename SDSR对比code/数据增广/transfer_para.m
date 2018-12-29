addpath('../../matlab/');
caffe.reset_all();
clear;
% The target network -- to be transfered
folder = './';
model = [folder 'FastARCNN_mat.prototxt'];
weights = [folder 'FastARCNN_iter_100.caffemodel'];
net_out = caffe.Net(model, weights,'test');

% The well-trained network
folder2 = './ARCNN/';
model2 = [folder2 'ARCNN_mat.prototxt'];
weights2 = [folder2 'ARCNN_iter_5000000.caffemodel'];
net_in = caffe.Net(model2, weights2,'test');

conv1=net_in.params('conv1', 1).get_data();
net_out.params('conv1', 1).set_data(conv1);
bias1=net_in.params('conv1', 2).get_data();
net_out.params('conv1', 2).set_data(bias1);
relu1=net_in.params('relu1', 1).get_data();
net_out.params('relu1', 1).set_data(relu1);

net_out.save(weights);

