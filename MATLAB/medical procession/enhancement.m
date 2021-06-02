clc;
clear;

im = imread('skeleton.jpg');

im1 = rgb2gray(im);
im = im1;
subplot(2,4,1)
imshow(im1);
im1 = im2double(im1);

%读取图像
s = size(im1);
h1 = s(1);
w1 = s(2);

%建立新的画布存储锐化后的图像
im2 = zeros(h1,w1);

%用laplacian判断锐化值
for i = 2:h1-1
    for j = 2:w1-1
        lap = 2*(im1(i+1,j)+im1(i-1,j)+im1(i,j+1)+im1(i,j-1)-4*im1(i,j));
        if lap~= 0
            im2(i,j) = -1*lap;
        end
    end
end
im22 = im2;
im2 = im2uint8(im2);
subplot(2,4,2)
imshow(im2);

im1 = im2uint8(im1);
%对原图像进行叠加
im1 = im1+im2;

subplot(2,4,3);
imshow(im1);

%Sobel梯度
im1 = im2double(im);
im3 = zeros(h1,w1);
%用Sobel Operator 进行梯度运算
for i = 2:h1-1
    for j = 2:w1-1
        im3(i,j) = 1*abs((im1(i+1,j-1)+2*im1(i+1,j)+im1(i+1,j+1))-(im1(i-1,j-1)+2*im1(i-1,j)+im1(i-1,j+1))) + abs((im1(i-1,j+1)+2*im1(i,j+1)+im1(i+1,j+1))-(im1(i-1,j-1)+2*im1(i,j-1)+im1(i+1,j-1)));
    end
end


im3 = im2uint8(im3);
subplot(2,4,4);
imshow(im3);

%用Sobel进行平滑滤波
im1 = im2double(im);
im4 = zeros(h1,w1);
for i = 3:h1-2
    for j = 3:w1-2
        im4(i,j) = avg(im1,i,j);
    end
end

im4 = im2uint8(im4);
subplot(2,4,5);
imshow(im4);

%第五章图和第2张图相乘的结果
im5 = im2double(im4).*im22;
im5 = im2uint8(im5);
subplot(2,4,6);
imshow(im5);

%第一张图和第六张图相加的结果
im6 = im2double(im)+im2double(im5);
im6 = im2uint8(im6);
subplot(2,4,7);
imshow(im6);



%用幂律变换
im7 = zeros(h1,w1);

im6= im2double(im6);

    
for i = 1:h1
    for j = 1:w1
        im7(i,j) =1*(im6(i,j)^0.5);
    end
end

im7 = im2uint8(im7);
subplot(2,4,8);
imshow(im7);


