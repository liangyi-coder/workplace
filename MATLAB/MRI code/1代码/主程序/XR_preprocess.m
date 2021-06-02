
clc;
close all;
clear all;
%�����������������
left=[1,2,7,8,9,11,12,13,15,17,18,19,21,24,25,28,29,31,32,33,34,35,37,38,41,42,43,45,47,48,50,52,54,57,58,59,65,66,68,70,71,72,73,75,78,85,86,87,88,93,100,102,103,104,105,112,113,114,115,117];
lr=zeros(1,121),lr(left)=1;%���������lrΪ1���������Ҳ�lrΪ0
%ͼ����Ҫ�󷴵Ĳ���
no_complement=[6,46,53,69,71,76,81,85:89,91,93,95,97,98,100,106,110:112,115,116,118,8,29,33,35,43,67,77,113];
mode{1}='CC';mode{2}='MLO';
for p=[1]%patient
   for imode=1:2%����CC/MLO
       if imode==1    
    IL1 = dicomread(['F:\���ٲ���\����\Xr\',num2str(p),'\Lcc.dcm']);%��ȡLccͼ��
    IR1 = dicomread(['F:\���ٲ���\����\Xr\',num2str(p),'\Rcc.dcm']);%��ȡRccͼ��
       else     
    IL1 = dicomread(['F:\���ٲ���\����\Xr\',num2str(p),'\LMlo.dcm']);%��ȡLMloͼ��
    IR1= dicomread(['F:\���ٲ���\����\Xr\',num2str(p),'\RMlo.dcm']);%��ȡRMloͼ��
       end
    IL= imresize(IL1,0.3);%ԭͼ�����
    IR= imresize(IR1,0.3);
    IL= double(IL);
    IR= double(IR);
    if ismember(p,no_complement)==0
    IL= imcomplement(IL);%ͼ����
    IR= imcomplement(IR);
    end
  %�Ҷ�ֵ��׼��0~4095
  IL=normalize(IL)*4095;
  IR=normalize(IR)*4095;
  [M,N]=size(IL);
  %ȥ��ע��λ�ÿɵ�
  IL(1:round(1/4*M),round(1/2*N):N)=0;
  IR(1:round(1/4*M),1:round(1/2*N))=0;
  threshold=400;
  IL(IL<threshold)=0;IR(IR<threshold)=0;%ȥ����
 %%%%%Mloͼ��ȥ�������߹�
 if imode==2
     %ȥ����
      xc=M/2;
         for i=1:N
         if IL(100,i)==0;
             yc=i;
            break
          end
         end
        IR=fliplr(IR);
        %yc��xcȷ����ֱ�߷ֿ����������٣��Զ�ȷ��Ч�����õĿ��Լ���
        %yc=
        for i=1:M
        for j=1:N
            y=-(yc/xc)*i+yc;
            if j<y
               IL(i,j)=0;
               IR(i,j)=0;
            end
        end
        end
    %ȥ�߹�
         xb=[];yb=[];
     for i=round(M*2/3):round(M*9/10)
        for j=1:round(N*1/2) 
            if IL(i,j)==0
                xb(end+1)=i;
                yb(end+1)=j;
               break
            end
        end
     end
     [minx,mini]=min(yb);
     ii=xb(mini):M;
     %x����ֵ��ii���²�����Ϊ�߹�ȥ�����ɵ�
     %ii=
             IL(ii,:)=0;
             IR(ii,:)=0;
       IR=fliplr(IR); 
     end
%Ip�没�����ڲ�ͼ��In�没��Բ�ͼ��
 if lr(p)==1
     Ip=IL;
     In=IR;
 else
     Ip=IR;
     In=IL;
 end
%��ֵ�˲�
% H = fspecial('average');
% Im=imfilter(Im,H,'same');
bw=morphology(Ip) ;%��̬ѧ����ָ���������ģ
Igrow_p=immultiply(Ip, bw);%�����Ӧ��ԭͼ��
[Imass_p]=boundingBox(Igrow_p);%�������������������С����
Igrow_n=immultiply(fliplr(logical(Igrow_p)),In);%���������Ӧ���Բ�����
[Imass_n]=boundingBox(Igrow_n);%������С����
[Ibreast_p]=boundingBox(Ip);%�����������������ͼ����С����
[Ibreast_n]=boundingBox(In);%�����Բ���������ͼ����С����
%С���任�õ�4���Ӵ�LL��LH��HL��HH
[LLmass_p  LHmass_p  HLmass_p  HHmass_p]=dwt2(Imass_p,'db1');
[LLmass_n  LHmass_n  HLmass_n  HHmass_n]=dwt2(Imass_n,'db1');
 [LLbreast_p  LHbreast_p  HLbreast_p  HHbreast_p]=dwt2(Ibreast_p,'db1');
[LLbreast_n  LHbreast_n  HLbreast_n  HHbreast_n]=dwt2(Ibreast_n,'db1');
 
%��ʾ�ָ���
% figure
% subplot(2,2,1),imshow(Ip,[]);
% subplot(222);imshow(Ip,[]),hold on;
% [c1,h1] =contour(logical(bw),'r-');
% subplot(2,2,3);imshow(Igrow_p,[]);
% subplot(2,2,4);imshow(Imass_p,[]);
figure
imshow(Ip,[]);hold on;
[c1,h1] =contour(logical(bw),'r-');

%ԭͼ��4��С���Ӵ�����in
%���没��������������Ӧ������������٣��Բ�����
% in{1}=Imass_p,in{2}=LLmass_p,in{3}=LHmass_p,in{4}=HLmass_p,in{5}=HHmass_p;
% save(['D:\����\�ҵĳ���\1����\XR\',mode{imode},'\��������\����\1\in_xr',num2str(p)],'in');
% in{1}=Imass_n,in{2}=LLmass_n,in{3}=LHmass_n,in{4}=HLmass_n,in{5}=HHmass_n;
% save(['D:\����\�ҵĳ���\1����\XR\',mode{imode},'\��������\����\2\in_xr',num2str(p)],'in');
% in{1}=Ibraast_p,in{2}=LLbraast_p,in{3}=LHbraast_p,in{4}=HLbraast_p,in{5}=HHbraast_p;
% save(['D:\����\�ҵĳ���\1����\XR\',mode{imode},'\��������\����\3\in_xr',num2str(p)],'in');
% in{1}=Ibraast_n,in{2}=LLbraast_n,in{3}=LHbraast_n,in{4}=HLbraast_n,in{5}=HHbraast_n;
% save(['D:\����\�ҵĳ���\1����\XR\',mode{imode},'\��������\����\4\in_xr',num2str(p)],'in');
    end
end
