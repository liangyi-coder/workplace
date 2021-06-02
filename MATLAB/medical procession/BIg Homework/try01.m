%对局部进行提取
clc;clear;close all;

im_o = dicomread('image\1.dcm');
figure;
subplot(1,3,1); imshow(im_o,[]);

im_l = dicomread('label\1.dcm');
subplot(1,3,2); imshow(im_l,[]);

im_h = histeq(im_o);
subplot(1,3,3); imshow(im_h);