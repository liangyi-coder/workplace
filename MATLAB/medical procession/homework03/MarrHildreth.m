function MarrHildreth

im = imread('house.tif');
im = im2double(im);
subplot(2,2,1); imshow(im);
s = size(im);
h = s(1);
w = s(2);
%用LoG对im进行滤波后拉普拉斯
gm = LoG(4,2);
im1 = zeros(h+4,w+4);
for i = 1:h
    for j = 1:w
        im1(i+2,j+2) = im(i,j);
    end
end
im2 = zeros(h,w);
for i = 3:h+2
    for j = 3:w+2
        im2(i,j) = 0;
        g = 0;
        for m = -2:2
            for n = -2:2
                g = g+gm(m+3,n+3);
                im2(i,j ) = im2(i,j) + gm(m+3,n+3)*im1(i+m,j+n);
            end
        end
        im2(i,j) = im2(i,j)/g;
    end
end
im3 = zeros(h,w);
for i = 2:h-1
    for j =2:w-1
        im3(i,j) = abs(4*im2(i,j)-im2(i+1,j)-im2(i-1,j)-im2(i,j+1)-im2(i,j-1));
    end
end
im4 = histeq(im3);
subplot(2,2,2); imshow(im4*0.6);

%过零点

end