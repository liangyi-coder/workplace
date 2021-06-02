function MorphologicalSmoothing2 

im = imread('starscloud.jpg');
im= rgb2gray(im);
subplot(2,2,1);imshow(im);

im = im2double(im);
s = size(im);
h = s(1);
w = s(2);
bg = im(1,1); 
%用半径为一的原盘进行平滑操作
im1 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        im1(i,j) = minGray_edge(1,im,i,j);
    end
end

im2 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        im2(i,j) = maxGray_edge(1,im1,i,j);
    end
end

im3 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        im3(i,j) = maxGray_edge(1,im2,i,j);
    end
end

im4 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        im4(i,j) = minGray_edge(1,im3,i,j);
    end
end
im4 = bgfilling(im4,bg,h,w);
subplot(2,2,2);imshow(im4);
%用半径为3的原盘进行平滑操作
im1 = zeros(h,w);
for i = 4:h-3
    for j = 4:w-3
        im1(i,j) = minGray_edge(3,im,i,j);
    end
end

im2 = zeros(h,w);
for i = 4:h-3
    for j = 4:w-3
        im2(i,j) = maxGray_edge(3,im1,i,j);
    end
end

im3 = zeros(h,w);
for i = 4:h-3
    for j = 4:w-3
        im3(i,j) = maxGray_edge(3,im2,i,j);
    end
end

im4 = zeros(h,w);
for i = 4:h-3
    for j = 4:w-3
        im4(i,j) = minGray_edge(3,im3,i,j);
    end
end
im4 = bgfilling(im4,bg,h,w);
subplot(2,2,3);imshow(im4);
%用半径为5的原盘进行平滑操作
im1 = zeros(h,w);
for i = 6:h-5
    for j = 6:w-5
        im1(i,j) = minGray_edge(5,im,i,j);
    end
end

im2 = zeros(h,w);
for i = 6:h-5
    for j = 6:w-5
        im2(i,j) = maxGray_edge(5,im1,i,j);
    end
end
im3 = zeros(h,w);
for i = 6:h-5
    for j = 6:w-5
        im3(i,j) = maxGray_edge(5,im2,i,j);
    end
end

im4 = zeros(h,w);
for i = 6:h-5
    for j = 6:w-5
        im4(i,j) = minGray_edge(5,im3,i,j);
    end
end
im4 = bgfilling(im4,bg,h,w);
subplot(2,2,4);imshow(im4);
end
