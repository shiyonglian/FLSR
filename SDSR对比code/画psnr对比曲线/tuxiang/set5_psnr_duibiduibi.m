load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\新建文件夹\psnr187_6_duibi.mat');
load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\新建文件夹\set5_duibi_scale1518000.mat');
load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\新建文件夹\psnr8000_duibi.mat');
step=1000
min_iter =1000;
max_iter=1518000;
psnr8000_short=psnr8000(1:1518);
psnr187_6_short=psnr187_6(1:1518)
psnr_bic=30.39;
SC=31.42;
NE_LLE=31.84;
ANR=31.92;
KK=32.28;
A=32.58;

x = min_iter : step : max_iter;

y1 = psnr_bic + zeros(size(x));
y2=SC+ zeros(size(x));
y3=NE_LLE + zeros(size(x));
y4=ANR + zeros(size(x));
y5=KK + zeros(size(x));
y6=A+ zeros(size(x));


plot(x,psnr8000_short,x,psnr187_6_short,x,psnr,'linewidth',2);

text(400000,33.40-0.09,'Our SDSR');
text(800000,32.85,'Small SDSR');
text(900000,32.25,'Smaller SDSR');



xlabel('Number of iteration')
ylabel('PSNR/dB');