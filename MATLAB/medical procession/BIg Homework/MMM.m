%MMA
function im_f = MMM(im,k,a)

s = size(im);
h = s(1);
w = s(2);

%�½�im_f��Ŵ�����ͼ��
im_f = zeros(h,w);

for i = 1+a:h-a
    for j = 1+a:w-a
        array = zeros((2*a+1)^2);
        %array��ȡ���������ڵ�����
        a_l = 1;
        for m = -a:a
            for n = -a:a
                array(a_l) = im(i+m,j+n);
                a_l = a_l+1;
            end
        end
        %�Դ��ڽ�������ȡ����ֵ
        array = sort(array);
        a_mid = array(round((2*a+1)^2/2));
        %����ֵ��������k�����غ���С��k������
        for m = 1:k
            array(m) = a_mid;
            array((2*a+1)^2+1-k) = a_mid;
        end
        %��array��ƽ��ֵ
        mean = 0;
        for m = 1:(2*a+1)^2
            mean = mean + array(m);
        end
        mean = mean/(2*a+1)^2;
        im_f(i,j) = mean;
    end
end
        

end