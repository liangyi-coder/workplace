function TBtrans4

im = imread('rice.jpg');
subplot(2,3,1);imshow(im);
im = rgb2gray(im);
s=size(im);


%��Otsu���ŷ�ֵ����im�Ľ��
level = graythresh(im);
im1 = im2bw(im,level);
subplot(2,3,2);imshow(im1);

imd = im2double(im);
%�뾶Ϊ8����ʴ
im2 = zeros(s(1),s(2));
for i = 1:s(1)
    for j = 1:s(2)
        im2(i,j) = minGray_edge(40,imd,i,j);
    end
end

subplot(2,3,3);imshow(im2);
%�뾶Ϊ8������
im3 = zeros(s(1),s(2));
for i = 1:s(1)
    for j = 1:s(2)
        im3(i,j) = maxGray_edge(40,im2,i,j);
    end
end
subplot(2,3,4);imshow(im3);

%��ñ�任
im4 = imd - im3;
subplot(2,3,5);imshow(im4);
        
%��Otsu���ŷ�ֵ����im4�Ľ�� 
level = graythresh(im4);
im5 = im2bw(im4,level);
subplot(2,3,6);imshow(im5);
end