load('C:\Users\fan\Desktop\小论文2\对比实验\tuxiang\psnr_set5_8000.mat');
step=10000
min_iter =10000;
max_iter=8000000;

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
psnr=psnr(10:10:8000)

plot(x,psnr,x,y1,x,y2,x,y3,x,y4,x,y5,x,y6,'linewidth',2);
text(6000000,psnr_bic+0.09,'Bicubic: 30.39 dB');
text(6000000,SC+0.09,'SC: 31.42 dB');
text(6000000,NE_LLE-0.09,'NE+LLE: 31.84 dB');
text(6000000,ANR+0.09,'ANR: 31.92 dB');
text(6000000,KK+0.09,'KK: 32.28 dB');
text(6000000,A+0.09,'A+: 32.58 dB');
text(6000000,33.40-0.09,'Our SDSR');


xlabel('Number of iteration')
ylabel('PSNR/dB');