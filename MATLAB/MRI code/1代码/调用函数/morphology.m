function [bw]=morphology(I) 
%ʹ����̬ѧ�ؽ�������ǰ��������б��
I1=normalize(I)*255;
    se = strel('disk', 20);%Բ�νṹԪ��
    Io = imopen(I1, se);%��̬ѧ������,ȥ��һЩ��С��Ŀ��
    Ie = imerode(I1, se);%��ͼ����и�ʴ
    Iobr = imreconstruct(Ie, I1);%��̬ѧ�ؽ�
    Ioc = imclose(Io, se);%��̬ѧ�ز���
    Iobrd = imdilate(Iobr, se);%��ͼ���������
    Iobrcbr = imreconstruct(imcomplement(Iobrd),...
        imcomplement(Iobr));%��̬ѧ�ؽ�
    Iobrcbr = imcomplement(Iobrcbr);%ͼ����
    fgm = imregionalmax(Iobrcbr);%�ֲ�����ֵ
    I2 = I1;
    I2(fgm) = 255;%�ֲ�����ֵ������ֵ��Ϊ255
    se2 = strel('disk',5);%�ṹԪ��
    fgm2 = imclose(fgm, se2);%�ز���
    fgm3 = imerode(fgm2, se2);%��ʴ
    fgm4 = bwareaopen(fgm3, 20);%������
    I3 = I1;
    I3(fgm4) = 255;%ǰ��������Ϊ255
    I4=double((I3==255));
    I4=imfill(I4,'hole');
    [bwlab,num]=bwlabel(I4);
S= regionprops(bwlab, 'Area');
%ȥ�������С����ͨ��,ȡ��ֵ������ͨ��
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
