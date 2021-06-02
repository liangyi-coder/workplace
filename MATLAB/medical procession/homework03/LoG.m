function gm = LoG(sigma,n)

gm = zeros(2*n+1,2*n+1);

for i = -n:n
    for j = -n:n
        gm(i+n+1,j+n+1) = -((i*i+j*j-2*sigma*sigma)/(sigma^4))^(exp(-(i*i+j*j)/(2*sigma*sigma)));
    end
end

end