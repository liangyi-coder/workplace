clc;
close all;
clear all;
%ָ��xxc1����Ϊ��������
xxc1=[520,550,536,526,520,485,366,502,524,410,...
520,482,524,528,518,518,478,526,514,502,...
476,520,498,484,444,522,518,454,452,464,...
484,532,506,504,482,494,520,440,536,530,...
498,496,440,518,526,476,460,434,530,492,...
518,526,528,456,414,530,450,552,534,495,...
510,460,518,530,460,466,472,476,506,448,...
512,494,530,478,420,436,604,516,506,542,...
446,530,430,462,530,464,536,450,454,528,...
448,542,568,462,504,640,522,470,450,454,...
530,504,520,458,536,440,528,520,464,502,...
462,468,484,438,446,446,460,440,524,518,...
524];
%kΪ������DCE���е�ͼ������
k(1:121)=78;k([18,23,28,64])=74;k(25)=76;k(48)=68;k(104)=66;k([75,96,102])=150;k([80,92])=160;
%�����������������
left=[1,2,6,7,8,9,11,12,13,15,17,18,19,21,24,25,28,29,31,32,33,34,35,37,38,41,42,43,45,47,48,50,52,54,57,58,59,65,66,68,70,71,72,73,75,78,85,86,87,88,93,100,102,103,104,105,112,113,114,115,117];
lr=zeros(1,121),lr(left)=1;%���������lrΪ1���������Ҳ�lrΪ0
for p=1:121%�������
    jj=1;
for  n1=(k(p)/2-19):(k(p)/2+20)%�����м��Ϊ����ȡ40��ͼƬ
if ismember(p,[ 69,71,83,91,93,95,98,106,112,116,118])
 fileform =[ 'G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\*.dcm'];
filepathsrc = ['G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\'];
file_outord = dir(fileform);
c1=struct2cell(file_outord);
c2=c1{1,n1};
I = dicomread([filepathsrc,c2])
elseif ismember(p,[ 75,80,92,96,102])
    
seq=1;
 n1=n1+k(p);
I = dicomread(['G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\',num2str(n1),'_',num2str((9*(n1-k(p)*seq-1))+(seq)),'.dcm']);
   I=imresize(imrotate(I,180),[1024,1024]);
else
    try
    I = dicomread(['G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
    catch
     I1 = dicomread(['G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
     I2 = dicomread(['G:\lymphatic metastasis prediction\MRI data\gaojie\dce',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%��ȡͼ�� 
     I=I1+I2;
    end
end
[M,N]=size(I);
I=histeq1(I);%ֱ��ͼ����  
I =double(I);
m_fil=5;sigma=0.1;
H=fspecial('gaussian',[m_fil m_fil],sigma);
I=imfilter(I,H,'same');%��˹�˲�
I3(:,:,jj)=I;%���ָ��ԭʼ3άͼ��1024*1024*40
jj=jj+1;
end
%ȥ������
xc=xxc1(p);
I3(1:xc,:)=0;
I3(I3<100)=0;%������ֵ 
%ȥ�������С����ͨ��
[bwlab,num]=bwlabeln(I3);
 S= regionprops(bwlab, 'Area');
bw1= ismember(bwlab, find([S.Area]<100));
I3(bw1)=0;
%�ֿ�������
ycenter=round(N/2);
IL=I3(:,1:ycenter,:);
IR=I3(:,ycenter:end,:);
%ȥ����Χ����ֵΪ0�ĵ㣬�������������������С����
[Ibreast]=boundingBox(I3);
[IL]=boundingBox(IL);
[IR]=boundingBox(IR);
%Ip�没�����ڲ����٣�In�没��Բ�����
if lr(p)==1
     Ip=IL;
     In=IR;
 else
     Ip=IR;
     In=IL;
end
%��ʾ������
figure
 imshow(Ibreast(:,:,20),[]);
figure
subplot(1,2,1),imshow(Ip(:,:,20),[]);
subplot(1,2,2),imshow(In(:,:,20),[]);
%�����������٣�Ibreast��������ࣨIp�����Բ���������In��
 in=Ibreast;
 save(['G:\lymphatic metastasis prediction\MRI data\save\5\in_mr',num2str(p)],'in');
 in=Ip;
 save(['G:\lymphatic metastasis prediction\MRI data\save\3\in_mr',num2str(p)],'in');
 in=In;
 save(['G:\lymphatic metastasis prediction\MRI data\save\4\in_mr',num2str(p)],'in');

end


