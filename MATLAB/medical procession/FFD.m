function FFD
im = imread('stone.jpg'); 
im = rgb2gray(im);
im = im2double(im);
subplot(2,3,1);imshow(im);
I = fft2(im);
K = fftshift(I);
KK = K;
F = abs(K);
T = log(F+1);
subplot(2,3,2);imshow(T,[]);
%imtool(T,[])

%观察图像，消除噪点
K(:,48:51)=0;
K(:,91:103)=0;
K(:,119:122)=0;
K(:,142:146)=0;
K(:,151:154)=0;
K(:,191:196)=0;
K(:,199:205)=0;
K(:,220:227)=0;
K(:,243:255)=0;
K(:,294:299)=0;
K(:,171:176)=0;

K(38:42,:)=0;
K(49:55,:)=0;
K(76:81,:)=0;
K(178:183,:)=0;
K(204:209,:)=0;
K(217:222,:)=0;
K(127:133,:)=0;

for i = 119:136
    for j = 164:184
        K(i,j) = KK(i,j);
    end
end


%将函数
F1 = abs(K);
T1 = log(F1+1);
subplot(2,3,3);imshow(T1,[]);

K1 = ifftshift(K);
I1 = ifft2(K1);
subplot(2,3,4);imshow(abs(I1));


subplot(2,3,5);imshow(I1,[]);
%T = abs(I1);
%imtool(T,[]);
%imshow(abs(I1));
end