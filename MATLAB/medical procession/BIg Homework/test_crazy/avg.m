function avg = avg(im,k,m,n)

avg = 0;
for i = m:m+k
    for j = n:n+k
        avg = avg + im(i,j);
    end
end

avg = avg/((k+1)*(k+1));
end

