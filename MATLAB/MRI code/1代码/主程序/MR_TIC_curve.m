clc;
close all;
clear all;
%nΪ����ͼ���в��������ԵĲ���
n=[41,48,24,45,43,38,71,46,50,31,...
24,42,44,36,52,56,48,15,40,25,...
41,37,15,40,24,23,42,39,37,45,...
35,37,55,30,56,50,39,56,46,34,...
57,27,37,29,35,45,30,54,43,53,...
47,50,44,25,49,33,40,35,16,31,...
38,36,34,46,50,49,33,36,28,48,...
47,41,34,66,49,55,25,53,36,100,...
43,27,44,26,39,42,44,32,32,48,...
30,45,50,38,49,60,28,44,44,46,...
40,51,40,40,52,51,42,26,33,40,....
48,35,36,37,44,55,27,54,48,45,...
47];
%kΪ������MASK���е�ͼ������
k(1:121)=78;k(25)=76;k(48)=68;k([88,104])=66;k([113,114])=70;
k([18,23,28,62,77,100])=74;
k([75,96,102])=150;k([80,92])=160;
pp=[1:121];%��121������
pp([13,14,15,21,23,25,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,107,109,112,116,118 ])=[];%��ͼ��ȫ��ԭ���ų�
val_p=[];val_n=[];%val_p�没��ࣨpositive��TIC���ߣ�1*9��MASK+8����ǿ���й�9��ʱ����Ӧ�Ĳ�������Ҷ�ƽ��ֵ����val_n��Բࣨnegative��TIC����
%%%%%%%%%%%%%%%����MASK����
 for p=[121]
     load(['E:\����\�ҵĳ���\1����\MR\DCE\��������\ԭʼ\grow\in_mr',num2str(p)]);%����������ģ
 n0=n(p);%�Բ���������һ��Ϊ��׼ȡ13��ͼƬ�����¿����������׿鲿��
 for i1=-6:6
     n1=n0+i1;
if ismember(p,[ 69,71,83,91,93,95,98,112,116,118])
 fileform =[ 'I:\���ٲ���\����\MASK\',num2str(p),'\*.dcm'];
filepathsrc = ['I:\���ٲ���\����\MASK\',num2str(p),'\'];
file_outord = dir(fileform);
c1=struct2cell(file_outord);
c2=c1{1,n1};
I = dicomread([filepathsrc,c2]);
elseif ismember(p,[106])
     I = dicomread(['I:\���ٲ���\����\MASK\',num2str(p),'\',num2str(n1),'.dcm']);%��ȡͼ�� 
elseif ismember(p,[ 75,80,92,96,102])
     I = dicomread(['I:\���ٲ���\����\DCE\',num2str(p),'\',num2str(n1),'_',num2str((9*(n1-1))),'.dcm']);
     I=imresize(imrotate(I,180),[1024,1024]);
else
  try
    I = dicomread(['I:\���ٲ���\����\MASK\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
    catch
     I1 = dicomread(['I:\���ٲ���\����\DCE\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
     I2 = dicomread(['I:\���ٲ���\����\Subtraction\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
     I=I1-I2;
    end
end
[M,N]=size(I);
I =double(I);
m_fil=5;sigma=0.1;
H=fspecial('gaussian',[m_fil m_fil],sigma);
I=imfilter(I,H,'same');
I3(:,:,i1+7)=I;%I3ΪMASK���к��������ڵ�13�ţ�1024*1024*13��
end    
val_p1=I3(logical(in));%ȡ������������صĻҶ�ֵ
val_n1=I3(fliplr(logical(in)));%ȡ�����ڶԲ�Ķ�Ӧ�����������صĻҶ�ֵ
val_p(1)=mean(val_p1);%��ֵ��Ϊ�����TIC���ߵ�һ��ʱ����ֵ
val_n(1)=mean(val_n1);%��ֵ��Ϊ�Բ�TIC���ߵ�һ��ʱ����ֵ     
     
%%%%%%%%%%%%%%%����DCE8������     
 for seq=0:7
  n0=n(p);
for i1=-6:6
    n1=n0+i1+seq*k(p);
if ismember(p,[ 69,71,83,91,93,95,98,106,112,116,118])
fileform =[ 'I:\���ٲ���\����\DCE\',num2str(p),'\*.dcm'];
filepathsrc = ['I:\���ٲ���\����\DCE\',num2str(p),'\'];
file_outord = dir(fileform);
c1=struct2cell(file_outord);
c2=c1{1,n1};
I = dicomread([filepathsrc,c2]);
elseif ismember(p,[ 75,80,92,96,102])
   I = dicomread(['I:\���ٲ���\����\DCE\',num2str(p),'\',num2str(n1),'_',num2str((9*(n1-k(p)*seq-1))+(seq)),'.dcm']);
   I=imresize(imrotate(I,180),[1024,1024]);
else
    try
    I = dicomread(['I:\���ٲ���\����\DCE\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
    catch
     I1 = dicomread(['I:\���ٲ���\����\MASK\',num2str(p),'\',num2str(n0+i1),'_',num2str(n0+i1-1),'.dcm']);%��ȡͼ�� 
     I2 = dicomread(['I:\���ٲ���\����\Subtraction\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
     I=I1+I2;
    end
end
I =double(I);
m_fil=5;sigma=0.1;
H=fspecial('gaussian',[m_fil m_fil],sigma);
I=imfilter(I,H,'same');
I3(:,:,i1+7)=I;%I3ΪDCE���к��������ڵ�13�ţ�1024*1024*13��
end
val_pi=I3(logical(in));%ȡ������������صĻҶ�ֵ
val_ni=I3(fliplr(logical(in)));%ȡ�����ڶԲ�Ķ�Ӧ�����������صĻҶ�ֵ
val_p(end+1)=mean(val_pi);%��ֵ��Ϊ�����TIC���ߵ�seq+2��2~9�������ֵ
val_n(end+1)=mean(val_ni);%��ֵ��Ϊ�Բ�TIC���ߵ�seq+2��2~9��һ�����ֵ   
 end
% ��ʾTIC���� 
     P_p=polyfit(1:9,val_p,7);%7�ζ���ʽ���
     P_n=polyfit(1:9,val_n,7);
     L=1:0.01:9;
     C_p=polyval(P_p,L);
     C_n=polyval(P_n,L);
     figure
     plot(L,C_p,'-');hold on
     plot(L,C_n,'--');
     legend('positive TIC ','negative TIC','Location','SouthEast');

%���没���ͶԲ�TIC����
 val=val_p;
 save(['E:\����\�ҵĳ���\1����\MR\DCE\��������\ԭʼ\TIC_p\in_mr',num2str(p)],'val');
 val=val_n;
 save(['E:\����\�ҵĳ���\1����\MR\DCE\��������\ԭʼ\TIC_n\in_mr',num2str(p)],'val');
     end  