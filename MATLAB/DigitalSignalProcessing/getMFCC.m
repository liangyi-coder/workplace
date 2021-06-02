function mm = getMFCC(x,fs)

bank=melbankm(24,256,fs,0,0.4,'t');%Mel�˲����Ľ���Ϊ24��fft�任�ĳ���Ϊ256������Ƶ��Ϊ16000Hz

%��һ��mel�˲�����ϵ��

bank=full(bank);

bank=bank/max(bank(:));

for k=1:12 %��һ��mel�˲�����ϵ��

n=0:23;

dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));

end

w=1+6*sin(pi*[1:12]./12);%��һ��������������

w=w/max(w);%Ԥ�����˲���

xx=double(x);

xx=filter([1-0.9375],1,xx);%�����źŷ�֡

xx=enframe(xx,256,80);%��x 256���Ϊһ֡

%����ÿ֡��MFCC����

for i=1:size(xx,1)

y=xx(i,:);

s=y'.*hamming(256);

t=abs(fft(s));%fft���ٸ���Ҷ�任

t=t.^2;

c1=dctcoef*log(bank*t(1:129));

c2=c1.*w';

m(i,:)=c2';

end

s = size(m,2);

for j = 1:s
    mm(j) = mean(m(:,j));
end