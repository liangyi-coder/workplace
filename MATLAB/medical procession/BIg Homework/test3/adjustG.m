%��������ʹ�λ
function aw = adjustG(im_o)

%��ȡͼ�����ֵ���ҵ�ͼ������ֵ����Сֵ���Ҷ�ֵ������0��255

s = size(im_o);
h = s(1);
w = s(2);
mini = min(min(im_o));
maxc = max(max(im_o));

aw = zeros(h,w);
%����ÿһ���ص�ֵ
for i = 1:h
    for j = 1:w
        aw(i,j) = (im_o(i,j)-mini)*256/(maxc-mini);
    end
end

end
        