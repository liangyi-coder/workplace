function [bw]=morphology(I) 
%使用形态学重建技术对前景对象进行标记
I1=normalize(I)*255;
    se = strel('disk', 20);%圆形结构元素
    Io = imopen(I1, se);%形态学开操作,去掉一些很小的目标
    Ie = imerode(I1, se);%对图像进行腐蚀
    Iobr = imreconstruct(Ie, I1);%形态学重建
    Ioc = imclose(Io, se);%形态学关操作
    Iobrd = imdilate(Iobr, se);%对图像进行膨胀
    Iobrcbr = imreconstruct(imcomplement(Iobrd),...
        imcomplement(Iobr));%形态学重建
    Iobrcbr = imcomplement(Iobrcbr);%图像求反
    fgm = imregionalmax(Iobrcbr);%局部极大值
    I2 = I1;
    I2(fgm) = 255;%局部极大值处像素值设为255
    se2 = strel('disk',5);%结构元素
    fgm2 = imclose(fgm, se2);%关操作
    fgm3 = imerode(fgm2, se2);%腐蚀
    fgm4 = bwareaopen(fgm3, 20);%开操作
    I3 = I1;
    I3(fgm4) = 255;%前景处设置为255
    I4=double((I3==255));
    I4=imfill(I4,'hole');
    [bwlab,num]=bwlabel(I4);
S= regionprops(bwlab, 'Area');
%去除面积过小的连通域,取均值最大的连通域
me=[];
for i=1:num
   Xi=bwlab;
   Xi(Xi~=i)=0;
   Xi(Xi==i)=1;
      area=sum(Xi(:));
   if area<1000
      Xi=0;
   end
   Xim=immultiply(I,Xi);
   Mask=Xim(logical(Xim));
   me(i)=mean(Mask(:));
   [a1,a2]=max(me);
end
bw=bwlab;
bw(bwlab~=a2)=0;
bw(bwlab==a2)=1;
