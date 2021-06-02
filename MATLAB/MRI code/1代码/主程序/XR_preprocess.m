
clc;
close all;
clear all;
%病灶在左侧的样本序号
left=[1,2,7,8,9,11,12,13,15,17,18,19,21,24,25,28,29,31,32,33,34,35,37,38,41,42,43,45,47,48,50,52,54,57,58,59,65,66,68,70,71,72,73,75,78,85,86,87,88,93,100,102,103,104,105,112,113,114,115,117];
lr=zeros(1,121),lr(left)=1;%病灶在左侧lr为1，病灶在右侧lr为0
%图像不需要求反的病例
no_complement=[6,46,53,69,71,76,81,85:89,91,93,95,97,98,100,106,110:112,115,116,118,8,29,33,35,43,67,77,113];
mode{1}='CC';mode{2}='MLO';
for p=[1]%patient
   for imode=1:2%处理CC/MLO
       if imode==1    
    IL1 = dicomread(['F:\乳腺病例\分类\Xr\',num2str(p),'\Lcc.dcm']);%读取Lcc图像
    IR1 = dicomread(['F:\乳腺病例\分类\Xr\',num2str(p),'\Rcc.dcm']);%读取Rcc图像
       else     
    IL1 = dicomread(['F:\乳腺病例\分类\Xr\',num2str(p),'\LMlo.dcm']);%读取LMlo图像
    IR1= dicomread(['F:\乳腺病例\分类\Xr\',num2str(p),'\RMlo.dcm']);%读取RMlo图像
       end
    IL= imresize(IL1,0.3);%原图像过大
    IR= imresize(IR1,0.3);
    IL= double(IL);
    IR= double(IR);
    if ismember(p,no_complement)==0
    IL= imcomplement(IL);%图像求反
    IR= imcomplement(IR);
    end
  %灰度值标准化0~4095
  IL=normalize(IL)*4095;
  IR=normalize(IR)*4095;
  [M,N]=size(IL);
  %去标注，位置可调
  IL(1:round(1/4*M),round(1/2*N):N)=0;
  IR(1:round(1/4*M),1:round(1/2*N))=0;
  threshold=400;
  IL(IL<threshold)=0;IR(IR<threshold)=0;%去背景
 %%%%%Mlo图像去胸廓和肋骨
 if imode==2
     %去胸廓
      xc=M/2;
         for i=1:N
         if IL(100,i)==0;
             yc=i;
            break
          end
         end
        IR=fliplr(IR);
        %yc与xc确定的直线分开胸廓与乳腺，自动确认效果不好的可自己给
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
    %去肋骨
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
     %x坐标值在ii以下部分作为肋骨去除，可调
     %ii=
             IL(ii,:)=0;
             IR(ii,:)=0;
       IR=fliplr(IR); 
     end
%Ip存病灶所在侧图像，In存病灶对侧图像
 if lr(p)==1
     Ip=IL;
     In=IR;
 else
     Ip=IR;
     In=IL;
 end
%均值滤波
% H = fspecial('average');
% Im=imfilter(Im,H,'same');
bw=morphology(Ip) ;%形态学处理分割，输出病灶掩模
Igrow_p=immultiply(Ip, bw);%病灶对应回原图像
[Imass_p]=boundingBox(Igrow_p);%保留包含病灶区域的最小矩形
Igrow_n=immultiply(fliplr(logical(Igrow_p)),In);%病灶区域对应到对侧乳腺
[Imass_n]=boundingBox(Igrow_n);%保留最小矩形
[Ibreast_p]=boundingBox(Ip);%保留病灶侧整体乳腺图像最小矩形
[Ibreast_n]=boundingBox(In);%保留对侧整体乳腺图像最小矩形
%小波变换得到4个子带LL，LH，HL，HH
[LLmass_p  LHmass_p  HLmass_p  HHmass_p]=dwt2(Imass_p,'db1');
[LLmass_n  LHmass_n  HLmass_n  HHmass_n]=dwt2(Imass_n,'db1');
 [LLbreast_p  LHbreast_p  HLbreast_p  HHbreast_p]=dwt2(Ibreast_p,'db1');
[LLbreast_n  LHbreast_n  HLbreast_n  HHbreast_n]=dwt2(Ibreast_n,'db1');
 
%显示分割结果
% figure
% subplot(2,2,1),imshow(Ip,[]);
% subplot(222);imshow(Ip,[]),hold on;
% [c1,h1] =contour(logical(bw),'r-');
% subplot(2,2,3);imshow(Igrow_p,[]);
% subplot(2,2,4);imshow(Imass_p,[]);
figure
imshow(Ip,[]);hold on;
[c1,h1] =contour(logical(bw),'r-');

%原图与4个小波子带存入in
%保存病灶区，病灶区对应区，病灶侧乳腺，对侧乳腺
% in{1}=Imass_p,in{2}=LLmass_p,in{3}=LHmass_p,in{4}=HLmass_p,in{5}=HHmass_p;
% save(['D:\乳腺\我的程序\1数据\XR\',mode{imode},'\输入腺体\输入\1\in_xr',num2str(p)],'in');
% in{1}=Imass_n,in{2}=LLmass_n,in{3}=LHmass_n,in{4}=HLmass_n,in{5}=HHmass_n;
% save(['D:\乳腺\我的程序\1数据\XR\',mode{imode},'\输入腺体\输入\2\in_xr',num2str(p)],'in');
% in{1}=Ibraast_p,in{2}=LLbraast_p,in{3}=LHbraast_p,in{4}=HLbraast_p,in{5}=HHbraast_p;
% save(['D:\乳腺\我的程序\1数据\XR\',mode{imode},'\输入腺体\输入\3\in_xr',num2str(p)],'in');
% in{1}=Ibraast_n,in{2}=LLbraast_n,in{3}=LHbraast_n,in{4}=HLbraast_n,in{5}=HHbraast_n;
% save(['D:\乳腺\我的程序\1数据\XR\',mode{imode},'\输入腺体\输入\4\in_xr',num2str(p)],'in');
    end
end
