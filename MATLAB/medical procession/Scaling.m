%放大图像
clc;
clear;
im1 = imread('beauty.png');

%读取图片大小
s = size(im1);
h = s(1);
w = s(2);
ch = s(3);

%缩放矩阵
T = [2,0;2,0];

%建立新画布
im2 = uint8(ones(2*h,2*w,ch));

%对原画进行放大
for i = 1:h
    for j = 1:w
        im2(2*i,2*j,:) = im1(i,j,:);
    end
end

%显示放大后的画
figure;
imshow(im2);