function  I=histeq1(I)
im=histeq(I);
mi=min(im(:));
im1=im+abs(mi);
im2=im1;
im2(im2>0)=1;
I=immultiply(I,im2);
