close all;
clc;
I=adjustW(dicomread('1.dcm'));
% I=rgb2gray(I);
figure;
subplot(3,3,1);imshow(I);title('ԭʼͼ��');
I1=im2double(I);
subplot(3,3,2);imshow(I1);title('Ԥ����');
I3=fftshift(fft2(I1));
I4=abs(I3);
I5=log(I4+1);
subplot(3,3,3);imshow(I5,[]);title('Ƶ����');
imtool(I5,[]);

%�þ�ֵ�˲�
figure;
H = [1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
I3 = filter2(H,I3);
I4 = abs(I3);
subplot(1,3,1); imshow(log(I4+1),[]);

T = ifftshift(I3);
subplot(1,3,2); imshow(log(T+1),[]);

T1=ifft2(T);%����Ҷ��任
T2=abs(T1);%abs
% subplot(3,3,6);imshow(I,[]);
subplot(1,3,3);imshow(T2,[]);title('final')

