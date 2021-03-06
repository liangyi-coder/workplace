function tef = twoEdgeF(img)

[m, n]=size(img);  
r=15;        %模板半径  
imgn=zeros(m+2*r+1,n+2*r+1);  
imgn(r+1:m+r,r+1:n+r)=img;  
imgn(1:r,r+1:n+r)=img(1:r,1:n);                 %扩展上边界  
imgn(1:m+r,n+r+1:n+2*r+1)=imgn(1:m+r,n:n+r);    %扩展右边界  
imgn(m+r+1:m+2*r+1,r+1:n+2*r+1)=imgn(m:m+r,r+1:n+2*r+1);    %扩展下边界  
imgn(1:m+2*r+1,1:r)=imgn(1:m+2*r+1,r+1:2*r);       %扩展左边界  
sigma_d=7; sigma_r=0.2;  
[x,y] = meshgrid(-r:r,-r:r);  
w1=exp(-(x.^2+y.^2)/(2*sigma_d^2));     %以距离作为自变量高斯滤波器  
for i=r+1:m+r  
    for j=r+1:n+r          
        w2=exp(-(imgn(i-r:i+r,j-r:j+r)-imgn(i,j)).^2/(2*sigma_r^2)); %以周围和当前像素灰度差值作为自变量的高斯滤波器  
        w=w1.*w2;  
        s=imgn(i-r:i+r,j-r:j+r).*w;  
        imgn(i,j)=sum(sum(s))/sum(sum(w));  
    end  
end  
tef = adjustW(imgn(r+1:m+r,r+1:n+r));
end