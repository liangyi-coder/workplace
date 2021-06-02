
%ͼ���˹ƽ���˲�����template����չ��sigma�Ǹ�˹�����Ĳ���
function gausTable = ImageSmoothing(template,sigma)
%��ȡͼƬ
im0 = imread('star.jpg');
im0 = rgb2gray(im0);
figure;
imshow(im0);

%��ȡͼƬ��С
s = size(im0);
h0 = s(1);
w0 = s(2);

%�����»���������ģ��

%�����»����ĸ߿�,im1���»�����h1,w1���»����ߺͿ�
h1 = h0 + template*2;
w1 = w0 + template*2;
im1 = zeros(h1,w1);

%���»����������
for i = 1:h0
    for j = 1:w0
        im1(template+i,template+j) = im0(i,j);
    end
end
        
%����һ����˹��
gausTable = zeros(2*template+1,2*template+1);
kx=template+1;
ky = kx;
for i = 1:template+1
    for j = 1:template+1
        gaus = exp(-((i-kx)*(i-kx)+(j-ky)*(j-ky))/(2*sigma));
        gausTable(i,j) = gaus;
        gausTable(2*(template+1)-i,j) = gaus;
        gausTable(i,2*(template+1)-j) = gaus;
        gausTable(2*(template+1)-i,2*(template+1)-j) = gaus;
    end
end

%��ԭͼ���ÿһ��ֵ�����˲�����,filter��ʾÿһ���˲�������ص�ֵ
for i = 1:h0
    for j = 1:w0
        filter = 0;
        w = 0;
        %������˹����
        for m = 1:2*template+1
            for n = 1:2*template+1
                filter = filter + gausTable(m,n)*im1(i+m-1,j+n-1);
                w = w + gausTable(m,n);
            end
        end
        im0(i,j) = filter/w;
    end
end

figure;
imshow(im0);
        
        
    
    
    

    











