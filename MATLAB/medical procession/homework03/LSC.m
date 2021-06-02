im=imread('house.tif');

subplot(231),imshow(im);

im1=edge(im,'sobel');
subplot(222),imshow(im1);

im2=edge(im,'log');
subplot(223),imshow(im2);

im3=edge(im,'canny');
subplot(224),imshow(im3);