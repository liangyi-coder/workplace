%调整窗宽和窗位
function aw = adjustG(im_o)

%读取图像的数值域，找到图像的最大值和最小值，灰度值调整到0到255

s = size(im_o);
h = s(1);
w = s(2);
mini = min(min(im_o));
maxc = max(max(im_o));

aw = zeros(h,w);
%调整每一像素的值
for i = 1:h
    for j = 1:w
        aw(i,j) = (im_o(i,j)-mini)*256/(maxc-mini);
    end
end

end
        