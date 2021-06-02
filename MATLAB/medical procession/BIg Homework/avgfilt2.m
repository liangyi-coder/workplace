%¾ùÖµÂË²¨Æ÷
function im_f=avgfilt2(im,a)
s = size(im);
h = s(1);
w = s(2);

im_f = zeros(h,w);
for i = a+1:h-a
    for j = a+1:w-a
        f = 0;
        for m = -a:a
            for n = -a:a
                f = f+im(i+m,j+n);
            end
        end
        f = f/(2*a+1)^2;
        im_f(i,j) = f;
    end
end

imshow(im_f);
end