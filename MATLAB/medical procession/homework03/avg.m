function avg = avg(k,im,i,j)
avg = 0;
for m = -k:k
    for n = -k:k
        avg = avg+im(i+m,j+n);
    end
end
avg = avg/((2*k+1)^2);
end