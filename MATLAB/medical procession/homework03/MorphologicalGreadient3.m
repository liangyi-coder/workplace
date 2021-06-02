function MorphologicalGreadient3
im = imread('brain.jpg');
im = rgb2gray(im);
subplot(2,2,1);imshow(im);

s = size(im);
h = s(1);
w = s(2);

im = im2double(im);
bg = im(3,3);

%∂‘im≈Ú’Õ
im1 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        max = im(i,j);
        for m = -1:1
            for n = -1:1
                if max < im(i+m,j+n)
                    max = im(i+m,j+n);
                end
            end
        end
        im1(i,j) = max;
    end
end
subplot(2,2,2);imshow(im1);

%∂‘im∏Ø ¥
im2 = zeros(h,w);
for i = 2:h-1
    for j = 2:w-1
        min = im(i,j);
        for m = -1:1
            for n = -1:1
                if min > im(i+m,j+n)
                    min = im(i+m,j+n);
                end
            end
        end
        im2(i,j) = min;
    end
end
subplot(2,2,3);imshow(im2);

%im1 - im3
im3 = im1 - im2;
subplot(2,2,4);imshow(im3);

end