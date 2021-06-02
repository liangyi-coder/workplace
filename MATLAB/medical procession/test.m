clc;
clear;

I = imread('skeleton.jpg');% ��ȡ��ɫͼ
I = rgb2gray(I);
subplot(131);
imshow(I);
title('��ɫͼ');


%I=rgb2gray(RGB);
%imshow(I);
%title('ԭʼ�Ҷ�ͼ��');

a=1;
model=[0 -2*a 0;-2*a 1+4*a -2*a;0 -2*a 0];
[m,n]=size(I);
Ig=I;
for i=2:m-1
    for j=2:n-1
        Ig(i,j)=(1+4*a).*I(i,j)-a.*(I(i+1,j)+I(i-1,j)+I(i,j+1)+I(i,j-1));
        %Ig(i,j)=sum(sum(Ig));
    end
end
Ig=Ig+I;
subplot(132);
imshow(uint8(Ig));
title('�񻯺��ͼ��');

Ig2=double(I); %��fת����һ����double��ͼ��Ȼ������˲�  
w=fspecial('laplacian',0);  
g1=imfilter(I,w,'replicate');  
g=I-g1;  
subplot(133);  
imshow(g); 
title('matlab�Դ�������');
