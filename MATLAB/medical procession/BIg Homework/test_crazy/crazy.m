%构建一个8*8的矩阵用来卷积，步长也是8


s = size(aw);
h = s(1);
w = s(2);

im1 = zeros(h,w);
for i = 1:2:h-2
    for j = 1:2:w-2
        avg = 0;
        for m = i:i+2
            for n = j:j+2
                avg = avg + aw(m,n);
            end
        end
        avg = avg/4;
        im1(i:i+2,j:j+2) = avg;
    end
end
        
imshow(im1);