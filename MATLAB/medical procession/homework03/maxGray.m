function max = maxGray(k,im,i,j)
max = im(i,j);
s = size(im);
h = s(1);
w = s(2);

top = 1;bottom = h;left = 1;right = w;
%������ط���Ҫ���ǻ᲻��Խ�������
if i > k && i+k <=h&& j > k && j+k <= w
    %��Խ���ʱ��
    top = i-k;bottom = i+k;
    left = j-k;right = j+k;
end
if i <= k
    %Խ�Ͻ��ʱ��
    top = 1;bottom = i+k;
    if j > k && j+k <= w
        %���Ҳ�Խ���ʱ��
        left = j-k;right = j+k;
    else if j <= k && j+k <= w
            %���Խ���ʱ��
            left = 1;right = j+k;
        else if j > k && j+k > w
                %�ұ�Խ���ʱ��
                left = j-k;right = w;
            end
        end
    end
end

if i+k > h
    %Խ�½��ʱ��
    top = i-k;bottom = h;
    if j > k && j+k <= w
        %���Ҳ�Խ���ʱ��
        left = j-k;right = j+k;
    else if j <= k && j+k <= w;
            %���Խ���ʱ��
            left = 1;right = j+k;
        else if j > k && j+k > w
                %�ұ�Խ���ʱ��
                left = j-k;right = w;
            end
        end
    end
end

for m = top:bottom
    for n = left:right
        if im(m,n) > max
            max = im(m,n);
        end
    end
end
end