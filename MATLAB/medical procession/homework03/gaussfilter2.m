%¸ßË¹ÂË²¨Æ÷
function im2=gaussfilter2(im,sigma)

s = size(im);
h = s(1);
w = s(2);

im1 = zeros(h+2*sigma,w+2*sigma);
for i = 1:h
    for j = 1:w
        im1(i+sigma,j+sigma) = im(i,j);
    end
end

gusT = zeros(2*sigma+1,2*sigma+1); 

for m = -sigma:sigma
    for n = -sigma:sigma
        gusT(m+sigma+1,n+sigma+1) = exp(-(m^2+n^2)/2*sigma^2);
    end
end

im2 = zeros(h,w);
for i=1:h
    for j = 1:w
        gs = 0;
        gsx = 0;
        for m = -sigma:sigma
            for n = -sigma:sigma
                gs = gs+gusT(m+sigma+1,n+sigma+1)*im1(i+sigma+m,j+sigma+n);
                gsx = gsx + gusT(m+sigma+1,n+sigma+1);
            end
        end
        im2(i,j) = gs/gsx;
    end
end

end