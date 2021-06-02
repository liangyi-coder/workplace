clear ;
clc;
f=imread('stone.jpg');
f=rgb2gray(f);
[f,revertclass]=tofloat(f);
PQ=paddedsize(size(f));
D0=0.05*PQ(2);
H=lpfilter('gaussian',PQ(1),PQ(2),D0);
mesh(H(1:10:500,1:10:500))
axis tight
F=fft2(f,PQ(1),PQ(2));
g=dftfilt(f,H);
g=revertclass(g);
subplot(221),imshow(f),title('原图像');
subplot(222),imshow(fftshift(H)),title('图像形式显示滤波器');
subplot(223),imshow(log(1+abs(fftshift(F))),[]),title('原图像的谱');
 subplot(224),imshow(g),title('滤波后的图像');