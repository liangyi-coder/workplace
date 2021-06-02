%计算一个正方形矩阵的均值
function avg = avg(im,i,j)
avg = 0;
for m = -2:2
    for n = -2:2
        avg = avg+im(i+m,j+n);
    end
end
avg = avg/25;
end