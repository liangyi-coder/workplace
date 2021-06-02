function Sobel
im = imread('house.tif');
im = im2double(im);
                                                                                                                                              
s = size(im);
h = s(1);
w = s(2);


figure;
subplot(2,2,1); imshow(im);
%先对噪声做平滑处理
ima = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        ima(i,j) = avg(1,im,i,j);
    end
end
%subplot(2,2,2); imshow(ima);
%Sobel水平方向
im1 =  edge(ima,'Sobel','horizontal');
subplot(2,2,2); imshow(im1);

%Sobel垂直方向
im2 = edge(ima,'Sobel','vertical');
subplot(2,2,3); imshow(im2);

subplot(2,2,4); imshow(im1+im2)


end