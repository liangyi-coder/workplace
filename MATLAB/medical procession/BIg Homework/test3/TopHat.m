function th = TopHat(im)

[h,w] = size(im);
im1 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im1(i,j) = minGray_edge(25,im,i,j);
    end
end

im2 = zeros(h,w);
for i = 1:h
    for j = 1:w
        im2(i,j) = maxGray_edge(25,im1,i,j);
    end
end
th = im - im2;
end