function min=minGray_edge(k,im,i,j)
%考虑边界的情况下求圆盘内的最小值
min = im(i,j);
s = size(im);
h = s(1);
w = s(2);

top = 1;bottom = h;left = 1;right = w;
%这这个地方主要考虑会不会越界的问题
if i > k && i+k <=h&& j > k && j+k <= w
    %不越界的时候
    top = i-k;bottom = i+k;
    left = j-k;right = j+k;
end
if i <= k
    %越上界的时候
    top = 1;bottom = i+k;
    if j > k && j+k <= w
        %左右不越界的时候
        left = j-k;right = j+k;
    else if j <= k && j+k <= w
            %左边越界的时候
            left = 1;right = j+k;
        else if j > k && j+k > w
                %右边越界的时候
                left = j-k;right = w;
            end
        end
    end
end

if i+k > h
    %越下届的时候
    top = i-k;bottom = h;
    if j > k && j+k <= w
        %左右不越界的时候
        left = j-k;right = j+k;
    else if j <= k && j+k <= w;
            %左边越界的时候
            left = 1;right = j+k;
        else if j > k && j+k > w
                %右边越界的时候
                left = j-k;right = w;
            end
        end
    end
end
            
for m = top:bottom
    for n = left:right
        if im(m,n) < min && sqrt((m-i)*(m-i)+(n-j)*(n-j))<=k
            min = im(m,n);
        end
    end
end
            

end