%��������ʹ�λ
function aw = adjustW(im_o)

%��ȡͼ�����ֵ���ҵ�ͼ������ֵ����Сֵ���Ҷ�ֵ������0��255

s = size(im_o);
h = s(1);
w = s(2);

%ͼ���һ��
im_d = im2double(im_o);
mini = min(min(im_d));
maxc = max(max(im_d));

aw = zeros(h,w);
%����ÿһ���ص�ֵ
for i = 1:h
    for j = 1:w
        aw(i,j) = (im_d(i,j)-mini)/(maxc-mini);
    end
end

end
        