function MorphologicalReconstruction1

im = imread('letters.png');
im = rgb2gray(im);
im = im2double(im);

%��ͼ�����Ԥֵ����
s = size(im);
h1 = s(1);
w1 = s(2);

im1 = zeros(h1+2,w1+2);
for i = 1:h1
    for j = 1:w1
        if im(i,j) <= 0.55
            im1(i+1,j+1) = 1;
        else
            im1(i+1,j+1) = 0;
        end
    end
end



%imtool(im1);
 subplot(2,2,1);imshow(im1);
%����һ��im2��Ÿ�ʴ���ͼ��
im2 = zeros(h1+2,w1+2);
 
%��se(��СΪ9*1)��im1����1�θ�ʴ
for i = 6:h1-5
    for j = 2:w1-1
        if im1(i-4:i+4,j) == 1
            im2(i,j) = 1;
        end
    end
end
subplot(2,2,2); imshow(im2);

%��se��im1��������,�γ�im3
im3 = zeros(h1+2,w1+2);
for i = 6:h1-5
    for j = 2:w1-1
        if im2(i,j) == 1
            im3(i-4:i+4,j) = 1;
        end
    end
end
subplot(2,2,3); imshow(im3);

%��im1Ϊmask��yong��һ��3*3�ľ����im3�����ع�
for i = 2:h1-1
    for j = 2:w1-1
        if im3(i,j) == 1 
            im3(i-1,j-1) = im1(i-1,j-1);
            im3(i-1,j) = im1(i-1,j);
            im3(i-1,j+1) = im1(i-1,j+1);
            im3(i,j-1) = im1(i,j-1);
            im3(i,j+1) = im1(i,j+1);
            im3(i+1,j-1) = im1(i+1,j-1);
            im3(i+1,j) = im1(i+1,j);
            im3(i+1,j+1) = im1(i+1,j+1);
        end
    end
end
subplot(2,2,4);imshow(im3);

            
end



