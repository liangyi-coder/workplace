function TextualSegmentation5

im= imread('points.jpg');
im = rgb2gray(im);
subplot(2,2,1);imshow(im);

%二值处理后闭运算
level = graythresh(im);
im1 = im2bw(im,level);

s = size(im1);
h = s(1);
w = s(2);
im2 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im2(i,j) = maxGray_edge(10,im1,i,j);
    end
end
im3 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im3(i,j) = minGray_edge(10,im2,i,j);
    end
end
subplot(2,2,2);imshow(im3);

%用半径为20的圆盘开运算
im4 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im4(i,j) = minGray_edge(20,im3,i,j);
    end
end
im5 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im5(i,j) = maxGray_edge(20,im4,i,j);
    end
end
subplot(2,2,3);imshow(im5);

%原图界限重叠

im6 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im6(i,j)=maxGray(1,im5,i,j)-minGray(1,im5,i,j);
    end
end
%将边界加到im中
im = im2double(im);
for i = 1:h
    for j = 1:w
        if im6(i,j) == 1
            im(i,j) = 1;
        end
    end
end

subplot(2,2,4);imshow(im);

end