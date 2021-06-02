function im2 = im2tri(im)

[h,w] = size(im);
im2 = zeros(h,w);
for i = 1:h
    for j = 1:w
        if im(i,j) >=0.3 && im(i,j)<=0.4
            im2(i,j) = 1;
        end
    end
end
end