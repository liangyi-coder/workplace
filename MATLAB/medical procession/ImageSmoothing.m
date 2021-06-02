
%图像高斯平滑滤波处理，template是扩展宽，sigma是高斯函数的参数
function gausTable = ImageSmoothing(template,sigma)
%读取图片
im0 = imread('star.jpg');
im0 = rgb2gray(im0);
figure;
imshow(im0);

%读取图片大小
s = size(im0);
h0 = s(1);
w0 = s(2);

%建立新画布，适配模板

%计算新画布的高宽,im1是新画布，h1,w1是新画布高和宽
h1 = h0 + template*2;
w1 = w0 + template*2;
im1 = zeros(h1,w1);

%对新画布进行填充
for i = 1:h0
    for j = 1:w0
        im1(template+i,template+j) = im0(i,j);
    end
end
        
%建立一个高斯表
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

%对原图像的每一个值进行滤波处理,filter表示每一个滤波后的像素的值
for i = 1:h0
    for j = 1:w0
        filter = 0;
        w = 0;
        %遍历高斯数组
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
        
        
    
    
    

    











