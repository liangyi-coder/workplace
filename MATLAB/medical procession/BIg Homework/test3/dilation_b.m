function close_b = dilation_b(im)

[h,w] = size(im);

im1 = im;

for i = 2:h-1
    for j = 2:w-1
        if im(i-1,j)+im(i+1,j)+im(i,j-1)+im(i,j+1)<=2
            im1(i,j) = 0;
        end
    end
end
close_b = im1;
end