function erosion_b = erosion_b(im)
[h,w] = size(im);

im1 = im;

for i = 2:h-1
    for j = 2:w-1
        if im(i-1,j)==1||im(i+1,j)==1||im(i,j-1)==1||im(i,j+1)==1
            im1(i,j) = 1;
        end
    end
end
erosion_b = im1;
end