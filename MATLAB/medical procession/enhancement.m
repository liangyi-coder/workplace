clc;
clear;

im = imread('skeleton.jpg');

im1 = rgb2gray(im);
im = im1;
subplot(2,4,1)
imshow(im1);
im1 = im2double(im1);

%��ȡͼ��
s = size(im1);
h1 = s(1);
w1 = s(2);

%�����µĻ����洢�񻯺��ͼ��
im2 = zeros(h1,w1);

%��laplacian�ж���ֵ
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
%��ԭͼ����е���
im1 = im1+im2;

subplot(2,4,3);
imshow(im1);

%Sobel�ݶ�
im1 = im2double(im);
im3 = zeros(h1,w1);
%��Sobel Operator �����ݶ�����
for i = 2:h1-1
    for j = 2:w1-1
        im3(i,j) = 1*abs((im1(i+1,j-1)+2*im1(i+1,j)+im1(i+1,j+1))-(im1(i-1,j-1)+2*im1(i-1,j)+im1(i-1,j+1))) + abs((im1(i-1,j+1)+2*im1(i,j+1)+im1(i+1,j+1))-(im1(i-1,j-1)+2*im1(i,j-1)+im1(i+1,j-1)));
    end
end


im3 = im2uint8(im3);
subplot(2,4,4);
imshow(im3);

%��Sobel����ƽ���˲�
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

%������ͼ�͵�2��ͼ��˵Ľ��
im5 = im2double(im4).*im22;
im5 = im2uint8(im5);
subplot(2,4,6);
imshow(im5);

%��һ��ͼ�͵�����ͼ��ӵĽ��
im6 = im2double(im)+im2double(im5);
im6 = im2uint8(im6);
subplot(2,4,7);
imshow(im6);



%�����ɱ任
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


