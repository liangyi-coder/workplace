clc;
clear;

im1 = imread('cell.jpg');
im2 = im1;
im = rgb2gray(im1);

[h,w] = size(im);

c = zeros(1,256);
for i = 1:h
    for j = 1:w
        c(1,im(i,j)) = c(1,im(i,j))+1;
    end
end

m = 0;
s = zeros(1,256);
for i = 1:256
    m = m+c(1,i);
    s(1,i) = m;
end

s1 = zeros(1,256);
for i = 1:h
    for j = 1:w
        im(i,j) = 256/(h*w)*s(im(i,j));
        s1(1,im(i,j)+1) = s1(1,im(i,j)+1)+1;
    end
end



figure;
imshow(im2);
figure;
bar(c);
figure;
imshow(im);
figure;
bar(s1);




    