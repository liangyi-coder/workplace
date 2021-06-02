%MMA
function im_f = MMM(im,k,a)

s = size(im);
h = s(1);
w = s(2);

%新建im_f存放处理后的图像
im_f = zeros(h,w);

for i = 1+a:h-a
    for j = 1+a:w-a
        array = zeros((2*a+1)^2);
        %array获取滑动窗口内的像素
        a_l = 1;
        for m = -a:a
            for n = -a:a
                array(a_l) = im(i+m,j+n);
                a_l = a_l+1;
            end
        end
        %对窗口进行排序，取得中值
        array = sort(array);
        a_mid = array(round((2*a+1)^2/2));
        %用中值代替最大的k个像素和最小的k个像素
        for m = 1:k
            array(m) = a_mid;
            array((2*a+1)^2+1-k) = a_mid;
        end
        %求array的平均值
        mean = 0;
        for m = 1:(2*a+1)^2
            mean = mean + array(m);
        end
        mean = mean/(2*a+1)^2;
        im_f(i,j) = mean;
    end
end
        

end