function SLC6
im1=imread('rice.jpg');
subplot(2,3,1),imshow(im1);

im2=edge(im,'sobel');
subplot(2,2,2),imshow(im2),title('sobelÍ¼Ïñ')

im3=edge(im,'log');
subplot(2,2,3),imshow(im3),title('logÍ¼Ïñ')

im4=edge(im,'canny');
subplot(2,2,4),imshow(im4),title('cannyÍ¼Ïñ')
end