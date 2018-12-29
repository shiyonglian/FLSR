clear
%folder0='Test';
folder0='Test_aug';
datapath='Test_aug/';
if(~isdir(datapath))
    mkdir(datapath);
end
filepaths=dir(fullfile(folder0,'*.jpg'));
Nimg=length(filepaths);
%Ifrot=0;
Ifrot=1;
for i=1:Nimg
    filename=filepaths(i).name;
    [imaddress,imname,type]=fileparts(filepaths(i).name);
    image=imread(fullfile(folder0,filename));
    if Ifrot
        im1=rot90(image,1);
        im2=rot90(image,2);
        im3=rot90(image,3);
        imwrite(im1,[datapath imname, '_rot90' '.jpg']);
        imwrite(im2,[datapath imname, '_rot180' '.jpg']);
        imwrite(im3,[datapath imname, '_rot270' '.jpg']);
    else
        im4=imresize(image,0.9,'bicubic');
        im5=imresize(image,0.8,'bicubic');
        im6=imresize(image,0.7,'bicubic');
        im7=imresize(image,0.6,'bicubic');
        imwrite(image,[datapath imname, '_s10' '.jpg']);
        imwrite(im4,[datapath imname, '_s9' '.jpg']);
        imwrite(im5,[datapath imname, '_s8' '.jpg']);
        imwrite(im6,[datapath imname, '_s7' '.jpg']);
        imwrite(im7,[datapath imname, '_s6' '.jpg']);
    end
    % 
end
