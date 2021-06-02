close all;
clc;
I=adjustW(dicomread('1.dcm'));
% I=rgb2gray(I);
figure;
subplot(3,3,1);imshow(I);title('原始图像');
I1=im2double(I);
subplot(3,3,2);imshow(I1);title('预处理');
I3=fftshift(fft2(I1));
I4=abs(I3);
I5=log(I4+1);
subplot(3,3,3);imshow(I5,[]);title('频率域');
imtool(I5,[]);

%用均值滤波
figure;
H = [1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
I3 = filter2(H,I3);
I4 = abs(I3);
subplot(1,3,1); imshow(log(I4+1),[]);

T = ifftshift(I3);
subplot(1,3,2); imshow(log(T+1),[]);

T1=ifft2(T);%傅里叶逆变换
T2=abs(T1);%abs
% subplot(3,3,6);imshow(I,[]);
subplot(1,3,3);imshow(T2,[]);title('final')

