clc;
close all;
clear all;
%���Լ��������������
malignent=[1,2,3,4,5,6,8,9,10,11,12,16,19,20,22,24,25,26,49,52,53,55,58,64,65,67,68,72,73,74,76,77,78,79,81,82,84,85];
benign=[7,17,18,27,28,29,30,31,33,34,35,36,38,39,40,41,42,43,44,45,47,48,54,56,57,59,60,61,62,63,66,88,90,97,99,100,101,104,108,110,111,113,114,115,117,119,120,121];
c_10=zeros(1,121),c_10(malignent)=1;%���������洢���ļ���0�£����������洢���ļ���1��
%�����洢�ļ�������
mode='DCE';
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
object={1,1:5,1:5,1:5,1:5,1:5};%shapeֻ����׿����,�������������׿飬���壬�׿�����������
decomposition={1,1:9,1:9,1:9,1:9,1:9};%shape,��������С���任��ֻ��ԭʼͼ��,����������С���任����ԭʼͼ���8��decomposition
i_feature=2;%ָ��Ҫ�����������1~6��fname��
for j=object{i_feature}
    if j==1
file{1}='�׿�p',file{2}='�׿�p��LLL��',file{3}='�׿�p��LLH��',file{4}='�׿�p��HLL��',file{5}='�׿�p��HLH��',file{6}='�׿�p��LHL��',file{7}='�׿�p��LHH��',file{8}='�׿�p��HHL��',file{9}='�׿�p��HHH��';
    elseif j==2
file{1}='�׿�n',file{2}='�׿�n��LLL��',file{3}='�׿�n��LLH��',file{4}='�׿�n��HLL��',file{5}='�׿�n��HLH��',file{6}='�׿�n��LHL��',file{7}='�׿�n��LHH��',file{8}='�׿�n��HHL��',file{9}='�׿�n��HHH��';
elseif j==3
file{1}='����p',file{2}='����p��LLL��',file{3}='����p��LLH��',file{4}='����p��HLL��',file{5}='����p��HLH��',file{6}='����p��LHL��',file{7}='����p��LHH��',file{8}='����p��HHL��',file{9}='����p��HHH��';
elseif j==4
file{1}='����n',file{2}='����n��LLL��',file{3}='����n��LLH��',file{4}='����n��HLL��',file{5}='����n��HLH��',file{6}='����n��LHL��',file{7}='����n��LHH��',file{8}='����n��HHL��',file{9}='����n��HHH��';
elseif j==5
file{1}='����',file{2}='���壨LLL��',file{3}='���壨LLH��',file{4}='���壨HLL��',file{5}='���壨HLH��',file{6}='���壨LHL��',file{7}='���壨LHH��',file{8}='���壨HHL��',file{9}='���壨HHH��';
    end
pp=[1:121];%��121������
pp([13,14,15,21,23,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,109,112,116,118 ])=[];%��ͼ��ȫ��ԭ���ų�
%%%%%%%%%%��������
for p=pp 
load(['E:\����\�ҵĳ���\1����\MR\',mode,'\��������\�任\',num2str(j),'\in_mr',num2str(p)]);
 % ����in��1*9 cell ���ֱ�Ϊԭʼ��LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH ͼ��
for i1=decomposition{i_feature}
   I=inm{i1};%��������������άͼ��
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
   end
save([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c_10(p)),'\',num2str(p)],'ff');
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
    file{1}='�׿�p',file{2}='�׿�p��LLL��',file{3}='�׿�p��LLH��',file{4}='�׿�p��HLL��',file{5}='�׿�p��HLH��',file{6}='�׿�p��LHL��',file{7}='�׿�p��LHH��',file{8}='�׿�p��HHL��',file{9}='�׿�p��HHH��';
    a1=load([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    file{1}='�׿�n',file{2}='�׿�n��LLL��',file{3}='�׿�n��LLH��',file{4}='�׿�n��HLL��',file{5}='�׿�n��HLH��',file{6}='�׿�n��LHL��',file{7}='�׿�n��LHH��',file{8}='�׿�n��HHL��',file{9}='�׿�n��HHH��';
    a2=load([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='�׿��',file{2}='�׿�LLL��',file{3}='�׿�LLH��',file{4}='�׿�HLL��',file{5}='�׿�HLH��',file{6}='�׿�LHL��',file{7}='�׿�LHH��',file{8}='�׿�HHL��',file{9}='�׿�HHH��';
    save([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
    
    file{1}='����p',file{2}='����p��LLL��',file{3}='����p��LLH��',file{4}='����p��HLL��',file{5}='����p��HLH��',file{6}='����p��LHL��',file{7}='����p��LHH��',file{8}='����p��HHL��',file{9}='����p��HHH��';
    a1=load([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    file{1}='����n',file{2}='����n��LLL��',file{3}='����n��LLH��',file{4}='����n��HLL��',file{5}='����n��HLH��',file{6}='����n��LHL��',file{7}='����n��LHH��',file{8}='����n��HHL��',file{9}='����n��HHH��';
    a2=load([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='�����',file{2}='����LLL��',file{3}='����LLH��',file{4}='����HLL��',file{5}='����HLH��',file{6}='����LHL��',file{7}='����LHH��',file{8}='����HHL��',file{9}='����HHH��';
    save([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
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
file{1}='�׿�p',file{2}='�׿�p��LLL��',file{3}='�׿�p��LLH��',file{4}='�׿�p��HLL��',file{5}='�׿�p��HLH��',file{6}='�׿�p��LHL��',file{7}='�׿�p��LHH��',file{8}='�׿�p��HHL��',file{9}='�׿�p��HHH��';
    elseif j==2
 file{1}='����',file{2}='���壨LLL��',file{3}='���壨LLH��',file{4}='���壨HLL��',file{5}='���壨HLH��',file{6}='���壨LHL��',file{7}='���壨LHH��',file{8}='���壨HHL��',file{9}='���壨HHH��';
elseif j==3
 file{1}='�׿��',file{2}='�׿�LLL��',file{3}='�׿�LLH��',file{4}='�׿�HLL��',file{5}='�׿�HLH��',file{6}='�׿�LHL��',file{7}='�׿�LHH��',file{8}='�׿�HHL��',file{9}='�׿�HHH��';
elseif j==4
 file{1}='�����',file{2}='����LLL��',file{3}='����LLH��',file{4}='����HLL��',file{5}='����HLH��',file{6}='����LHL��',file{7}='����LHH��',file{8}='����HHL��',file{9}='����HHH��';
    end
for i1=decomposition{i_feature}
    f=[];%�洢�ϲ�������ݼ�
    for p=pp
    a1=load([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    a=a1.ff
    f=[f;a];
   end
     save([ 'E:\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\zong1'],'f');
end   
end
end