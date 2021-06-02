function tef = twoEdgeF(img)

[m, n]=size(img);  
r=15;        %ģ��뾶  
imgn=zeros(m+2*r+1,n+2*r+1);  
imgn(r+1:m+r,r+1:n+r)=img;  
imgn(1:r,r+1:n+r)=img(1:r,1:n);                 %��չ�ϱ߽�  
imgn(1:m+r,n+r+1:n+2*r+1)=imgn(1:m+r,n:n+r);    %��չ�ұ߽�  
imgn(m+r+1:m+2*r+1,r+1:n+2*r+1)=imgn(m:m+r,r+1:n+2*r+1);    %��չ�±߽�  
imgn(1:m+2*r+1,1:r)=imgn(1:m+2*r+1,r+1:2*r);       %��չ��߽�  
sigma_d=7; sigma_r=0.2;  
[x,y] = meshgrid(-r:r,-r:r);  
w1=exp(-(x.^2+y.^2)/(2*sigma_d^2));     %�Ծ�����Ϊ�Ա�����˹�˲���  
for i=r+1:m+r  
    for j=r+1:n+r          
        w2=exp(-(imgn(i-r:i+r,j-r:j+r)-imgn(i,j)).^2/(2*sigma_r^2)); %����Χ�͵�ǰ���ػҶȲ�ֵ��Ϊ�Ա����ĸ�˹�˲���  
        w=w1.*w2;  
        s=imgn(i-r:i+r,j-r:j+r).*w;  
        imgn(i,j)=sum(sum(s))/sum(sum(w));  
    end  
end  
tef = adjustW(imgn(r+1:m+r,r+1:n+r));
end