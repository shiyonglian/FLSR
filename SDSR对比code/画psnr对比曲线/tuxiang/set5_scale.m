load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\新建文件夹\psnr949_duibi.mat');
load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\新建文件夹\psnr8000_duibi.mat');
step=1000
min_iter =1000;
max_iter=949000;
psnr8000_short=psnr8000(1:949);

psnr_bic=30.39;
SC=31.42;
NE_LLE=31.84;
ANR=31.92;
KK=32.28;
A=32.58;

x = min_iter : step : max_iter;


plot(x,psnr8000_short,x,psnr949,'linewidth',2);

text(400000,33.40-0.09,'Our SDSR');
text(550000,32.75,'None multi-scale SDSR');



xlabel('Number of iteration')
ylabel('PSNR/dB');