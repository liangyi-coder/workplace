%�Ŵ�ͼ��
clc;
clear;
im1 = imread('beauty.png');

%��ȡͼƬ��С
s = size(im1);
h = s(1);
w = s(2);
ch = s(3);

%���ž���
T = [2,0;2,0];

%�����»���
im2 = uint8(ones(2*h,2*w,ch));

%��ԭ�����зŴ�
for i = 1:h
    for j = 1:w
        im2(2*i,2*j,:) = im1(i,j,:);
    end
end

%��ʾ�Ŵ��Ļ�
figure;
imshow(im2);