clc;
close all;
clear all;

mode='DCE';
file=cell(1,4);
for j=1:5
file{1}='�׿�p',file{2}='�׿�n',file{3}='����p',file{4}='����n',file{5}='����';
pp=[1:121];%��121������
pp([13,14,15,21,23,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,109,112,116,118 ])=[];%��ͼ��ȫ��ԭ���ų�
for p=pp 
load(['E:\����\�ҵĳ���\1����\MR\',mode,'\��������\ԭʼ\',num2str(j),'\in_mr',num2str(p)]);
 I=in;
 [LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH]=dwt3d(I);%��άС���任�õ��˸��Ӵ�
  %ԭʼ����ͼ������˸�С���Ӵ�����inm��
 inm{1}=I;
 inm{2}=LLL;inm{3}=LLH;inm{4}=HLL;inm{5}=HLH;inm{6}=LHL;inm{7}=LHH;inm{8}=HHL;inm{9}=HHH;
 %����inm
 save(['E:\����\�ҵĳ���\1����\MR\',mode,'\��������\�任\',num2str(j),'\in_mr',num2str(p)],'inm');
 end
end

