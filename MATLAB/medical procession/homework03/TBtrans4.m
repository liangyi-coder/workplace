function TBtrans4

im = imread('rice.jpg');
subplot(2,3,1);imshow(im);
im = rgb2gray(im);
s=size(im);


%用Otsu最优阀值处理im的结果
level = graythresh(im);
im1 = im2bw(im,level);
subplot(2,3,2);imshow(im1);

imd = im2double(im);
%半径为8，腐蚀
im2 = zeros(s(1),s(2));
for i = 1:s(1)
    for j = 1:s(2)
        im2(i,j) = minGray_edge(40,imd,i,j);
    end
end

subplot(2,3,3);imshow(im2);
%半径为8，膨胀
im3 = zeros(s(1),s(2));
for i = 1:s(1)
    for j = 1:s(2)
        im3(i,j) = maxGray_edge(40,im2,i,j);
    end
end
subplot(2,3,4);imshow(im3);

%顶帽变换
im4 = imd - im3;
subplot(2,3,5);imshow(im4);
        
%用Otsu最优阀值处理im4的结果 
level = graythresh(im4);
im5 = im2bw(im4,level);
subplot(2,3,6);imshow(im5);
end