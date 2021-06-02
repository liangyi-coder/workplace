% function Canny
clc;
clear;

im = imread('house.tif');

im = im2double(im);
s = size(im);
h = s(1);
w = s(2);
subplot(2,2,1); imshow(im);
im1 = gaussfilter2(im,2);

%计算梯度图像
im2 = zeros(h+2,w+2);
for i = 1:h
    for j = 1:w
        im2(i+1,j+1) = im1(i,j);
    end
end

%用Sobel算子求im在x和y方向的梯度
imx = zeros(h,w);
imy = zeros(h,w);
for i = 1:h
    for j = 1:w
        imx(i,j) = im2(i+2,j)+2*im2(i+2,j+1)+im2(i+2,j+2)-im2(i,j)-2*im2(i,j+1)-im2(i,j+2);
        imy(i,j) = im2(i,j+2)+2*im2(i+1,j+2)+im2(i+2,j+2)-im2(i,j)-2*im2(i+1,j)-im2(i+2,j);
    end
end
for i = 1:h
    for j =1:w
        imG(i,j) = sqrt(imx(i,j)^2+imy(i,j)^2);
    end
end
subplot(2,2,2); imshow(imG);
imD = zeros(h,w);
for i = 1:h
    for j = 1:w
        imD(i,j) = atan(imy(i,j)/imx(i,j))*180/pi;
    end
end
% subplot(2,2,2); imshow(imD);

%用3X3的核产生一幅非极大值抑制图像
im2 = zeros(h+2,w+2);
for i = 1:h
    for j = 1:w
        im2(i+1,j+1) = imG(i,j);
    end
end

imDx = zeros(h,w);
for i = 1:h
    for j = 1:w
        if imD(i,j) >=-22.5 && imD(i,j) <= 22.5 ||  imD(i,j) >=-180 && imD(i,j) <= -157.5 ||  imD(i,j) >=157.5 && imD(i,j) <= 180
            imDx(i,j) = 1;
        end
        if imD(i,j) >=67.5 && imD(i,j) <= 112.5 ||  imD(i,j) >=-112.5 && imD(i,j) <= -67.5 
            imDx(i,j) = 2;
        end
        if imD(i,j) >=22.5 && imD(i,j) <= 67.5 ||  imD(i,j) >=-157.5 && imD(i,j) <= -112.5
            imDx(i,j) = 3;
        end
        if imD(i,j) >=112.5 && imD(i,j) <= 157.5 ||  imD(i,j) >=-67.5 && imD(i,j) <= -22.5 
            imDx(i,j) = 4;
        end
    end
end

im3 = zeros(h,w);
for i = 2:h+1
    for j =2:w+1
        if imDx(i-1,j-1) == 1
            if im2(i,j) < im2(i+1,j) || im2(i,j) < im2(i-1,j)
                imG(i-1,j-1) = 0;
            end
        end
        if imDx(i-1,j-1) == 2
            if im2(i,j) < im2(i,j+1) || im2(i,j) < im2(i,j-1)
                imG(i-1,j-1) = 0;
            end
        end
        if imDx(i-1,j-1) == 3
            if im2(i,j) < im2(i-1,j-1) || im2(i,j) < im2(i+1,j+1)
                imG(i-1,j-1) = 0;
            end
        end
        if imDx(i-1,j-1) == 4
            if im2(i,j) < im2(i+1,j-1) || im2(i,j) < im2(i-1,j+1)
                imG(i-1,j-1) = 0;
            end
        end
    end
end

subplot(2,2,3); imshow(imG);
    
% end