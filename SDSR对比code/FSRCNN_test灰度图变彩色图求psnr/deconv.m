function im_output = deconv(im_input, filter, stride)
border = 1;
[hei0, wid0] = size(im_input);
im_input = padarray(im_input,[border, border],'replicate');
[hei, wid] = size(im_input);
fsize = size(filter,1);
outhei = hei * stride;
outwid = wid * stride;
output = zeros(outhei + fsize - 1, outwid + fsize - 1);
for i = 1 : hei
    for j = 1 : wid
        idx = 1 + (i-1)*stride;
        idy = 1 + (j-1)*stride;
        output(idx : idx + fsize - 1, idy : idy + fsize - 1) = ...
            output(idx : idx + fsize - 1, idy : idy + fsize - 1) + im_input(i,j) * filter;
    end
end
outhei = hei0 * stride;
outwid = wid0 * stride;
im_output = output((fsize + 1)/2 + stride * border : outhei + (fsize + 1)/2 + stride * border - 1,...
    (fsize + 1)/2 + stride * border : outwid + (fsize + 1)/2 + stride * border - 1);