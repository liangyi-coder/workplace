clc;
close all;
clear all;
%���Լ��������������
malignent=[1,2,3,4,5,6,8,9,10,11,12,13,14,16,19,20,22,23,24,25,26,49,52,53,55,58,64,65,67,68,69,71,72,73,74,76,77,78,79,80,81,82,84,85,116];
benign=[7,17,18,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,54,56,57,59,60,61,62,63,66,86,88,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,108,109,110,111,112,113,114,115,117,118,119,120,121];
c_10=zeros(1,121),c_10(malignent)=1;%���������洢���ļ���0�£����������洢���ļ���1��
%�����洢�ļ�������
mode='CC';%�˴��л�CC��Mlo
% mode='Mlo'
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
fname{7}='wld';
fname{8}='gabor';
object={1,1:4,1:4,1:4,1:4,1:4,1:2,1:4};%shapeֻ����׿����,wldֻ����׿���׿������������������׿飬���壬�׿�����������
decomposition={1,1:5,1:5,1:5,1:5,1:5,1:5,1:5,};%shape��������С���任��ֻ��ԭʼͼ��,����������С���任����ԭʼͼ���4��decomposition
i_feature=1;%ָ��Ҫ�����������1~8��fname��

for j=object{i_feature}
   if j==1
file{1}='�׿�p',file{2}='�׿�p��LL��',file{3}='�׿�p��LH��',file{4}='�׿�p��HL��',file{5}='�׿�p��HH��';
    elseif j==2
file{1}='�׿�n',file{2}='�׿�n��LL��',file{3}='�׿�n��LH��',file{4}='�׿�n��HL��',file{5}='�׿�n��HH��';
elseif j==3
file{1}='����p',file{2}='����p��LL��',file{3}='����p��LH��',file{4}='����p��HL��',file{5}='����p��HH��';
elseif j==4
file{1}='����n',file{2}='����n��LL��';file{3}='����n��LH��',file{4}='����n��HL��',file{5}='����n��HH��';
    end
pp=[1:121];%��121������
pp([15,21,70,75,83,107,50,87,89 ])=[];%��ͼ��ȫ��ԭ���ų�
%%%%%%%%%%��������
for p=pp 
load(['D:\����\�ҵĳ���\1����\XR\',mode,'\��������\����\',num2str(j),'\in_xr',num2str(p)]);
% ����in��1*5 cell ���ֱ�Ϊԭʼ��LL��LH��HL��HH ͼ��
for i1=decomposition{i_feature}
   I=in{i1};%�����������Ķ�άͼ��
   if i_feature==1
   ff=shape1(I);
   elseif i_feature==2
   ff=statistics1(I);
   elseif i_feature==3
   ff=glcm1(I);
   elseif i_feature==4
   ff=glrl1(I);
   elseif i_feature==5
   ff=glszm1(I);
   elseif i_feature==6
   ff=ngtdm1(I);
   elseif i_feature==7
   ff=wld1(I);
   elseif i_feature==8
   ff=gabor1(I);
   end
save([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c_10(p)),'\',num2str(p)],'ff');
 end
end
end

%%%%%%%%%%%�����׿��������
if  i_feature~=1 %shape������� 
for c1=[0,1]%c1Ϊ0ȡ����������Ϊ1ȡ��������
 if c1==1
        pp=malignent;
 else
        pp=benign;
 end
 for i1=decomposition{i_feature}
    for p=pp
     file{1}='�׿�p',file{2}='�׿�p��LL��',file{3}='�׿�p��LH��',file{4}='�׿�p��HL��',file{5}='�׿�p��HH��';
     a1=load([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
   file{1}='�׿�n',file{2}='�׿�n��LL��',file{3}='�׿�n��LH��',file{4}='�׿�n��HL��',file{5}='�׿�n��HH��';
    a2=load([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
     file{1}='�׿��',file{2}='�׿�LL��',file{3}='�׿�LH��',file{4}='�׿�HL��',file{5}='�׿�HH��';
save([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
    
     file{1}='����p',file{2}='����p��LL��',file{3}='����p��LH��',file{4}='����p��HL��',file{5}='����p��HH��';
    a3=load([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
   file{1}='����n',file{2}='����n��LL��',file{3}='����n��LH��',file{4}='����n��HL��',file{5}='����n��HH��';
    a4=load([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='�����',file{2}='����LL��',file{3}='����LH��',file{4}='����HL��',file{5}='����HH��';
 save([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
   end
end   
end
end


%���ϼ��������ÿ�����ߴ�һ��mat���˴����кϲ�
%�����ж��������ϲ���һ�����ݼ���m*n����mΪ������������nΪ����ά����
%���������������ϲ���һ�����ݼ���m*n����mΪ������������nΪ����ά����
for c1=[0,1]%c1Ϊ0ȡ����������Ϊ1ȡ��������
if c1==1
        pp=malignent;
    else
       pp=benign;
    end
for j=object{i_feature}
    if j==1
file{1}='�׿�p',file{2}='�׿�p��LL��',file{3}='�׿�p��LH��',file{4}='�׿�p��HL��',file{5}='�׿�p��HH��';
    elseif j==2
file{1}='����p',file{2}='����p��LL��',file{3}='����p��LH��',file{4}='����p��HL��',file{5}='����p��HH��';
elseif j==3
file{1}='�׿��',file{2}='�׿�LL��',file{3}='�׿�LH��',file{4}='�׿�HL��',file{5}='�׿�HH��';
elseif j==4
file{1}='�����',file{2}='����LL��',file{3}='����LH��',file{4}='����HL��',file{5}='����HH��';
    end
for i1=decomposition{i_feature}
    f=[];%�洢�ϲ�������ݼ�
    for p=pp
    a1=load([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    a=a1.ff
    f=[f;a];
   end
    save([ 'D:\����\�ҵĳ���\1����\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\zong1'],'f');
end   
end
end