clc;
close all;
clear all;
%恶性及良性样本的序号
malignent=[1,2,3,4,5,6,8,9,10,11,12,13,14,16,19,20,22,23,24,25,26,49,52,53,55,58,64,65,67,68,69,71,72,73,74,76,77,78,79,80,81,82,84,85,116];
benign=[7,17,18,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,51,54,56,57,59,60,61,62,63,66,86,88,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,108,109,110,111,112,113,114,115,117,118,119,120,121];
c_10=zeros(1,121),c_10(malignent)=1;%良性样本存储在文件夹0下，恶性样本存储在文件夹1下
%特征存储文件夹名称
mode='CC';%此处切换CC与Mlo
% mode='Mlo'
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
fname{7}='wld';
fname{8}='gabor';
object={1,1:4,1:4,1:4,1:4,1:4,1:2,1:4};%shape只针对肿块计算,wld只针对肿块和肿块差，计算其他特征基于肿块，整体，肿块差和整体差计算
decomposition={1,1:5,1:5,1:5,1:5,1:5,1:5,1:5,};%shape特征不做小波变换，只用原始图像,其余特征做小波变换，有原始图像和4个decomposition
i_feature=1;%指定要计算的特征（1~8见fname）

for j=object{i_feature}
   if j==1
file{1}='肿块p',file{2}='肿块p（LL）',file{3}='肿块p（LH）',file{4}='肿块p（HL）',file{5}='肿块p（HH）';
    elseif j==2
file{1}='肿块n',file{2}='肿块n（LL）',file{3}='肿块n（LH）',file{4}='肿块n（HL）',file{5}='肿块n（HH）';
elseif j==3
file{1}='整体p',file{2}='整体p（LL）',file{3}='整体p（LH）',file{4}='整体p（HL）',file{5}='整体p（HH）';
elseif j==4
file{1}='整体n',file{2}='整体n（LL）';file{3}='整体n（LH）',file{4}='整体n（HL）',file{5}='整体n（HH）';
    end
pp=[1:121];%共121个样本
pp([15,21,70,75,83,107,50,87,89 ])=[];%因图像不全等原因排除
%%%%%%%%%%特征计算
for p=pp 
load(['D:\乳腺\我的程序\1数据\XR\',mode,'\输入腺体\输入\',num2str(j),'\in_xr',num2str(p)]);
% 读入in，1*5 cell ，分别为原始，LL，LH，HL，HH 图像
for i1=decomposition{i_feature}
   I=in{i1};%待计算特征的二维图像
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
save([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c_10(p)),'\',num2str(p)],'ff');
 end
end
end

%%%%%%%%%%%计算肿块差和整体差
if  i_feature~=1 %shape不计算差 
for c1=[0,1]%c1为0取良性样本，为1取恶性样本
 if c1==1
        pp=malignent;
 else
        pp=benign;
 end
 for i1=decomposition{i_feature}
    for p=pp
     file{1}='肿块p',file{2}='肿块p（LL）',file{3}='肿块p（LH）',file{4}='肿块p（HL）',file{5}='肿块p（HH）';
     a1=load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
   file{1}='肿块n',file{2}='肿块n（LL）',file{3}='肿块n（LH）',file{4}='肿块n（HL）',file{5}='肿块n（HH）';
    a2=load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
     file{1}='肿块差',file{2}='肿块差（LL）',file{3}='肿块差（LH）',file{4}='肿块差（HL）',file{5}='肿块差（HH）';
save([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
    
     file{1}='整体p',file{2}='整体p（LL）',file{3}='整体p（LH）',file{4}='整体p（HL）',file{5}='整体p（HH）';
    a3=load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
   file{1}='整体n',file{2}='整体n（LL）',file{3}='整体n（LH）',file{4}='整体n（HL）',file{5}='整体n（HH）';
    a4=load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='整体差',file{2}='整体差（LL）',file{3}='整体差（LH）',file{4}='整体差（HL）',file{5}='整体差（HH）';
 save([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
   end
end   
end
end


%以上计算的特征每个患者存一个mat，此处进行合并
%将所有恶性样本合并成一个数据集，m*n，（m为恶性样本数，n为特征维数）
%将所有良性样本合并成一个数据集，m*n，（m为良性样本数，n为特征维数）
for c1=[0,1]%c1为0取良性样本，为1取恶性样本
if c1==1
        pp=malignent;
    else
       pp=benign;
    end
for j=object{i_feature}
    if j==1
file{1}='肿块p',file{2}='肿块p（LL）',file{3}='肿块p（LH）',file{4}='肿块p（HL）',file{5}='肿块p（HH）';
    elseif j==2
file{1}='整体p',file{2}='整体p（LL）',file{3}='整体p（LH）',file{4}='整体p（HL）',file{5}='整体p（HH）';
elseif j==3
file{1}='肿块差',file{2}='肿块差（LL）',file{3}='肿块差（LH）',file{4}='肿块差（HL）',file{5}='肿块差（HH）';
elseif j==4
file{1}='整体差',file{2}='整体差（LL）',file{3}='整体差（LH）',file{4}='整体差（HL）',file{5}='整体差（HH）';
    end
for i1=decomposition{i_feature}
    f=[];%存储合并后的数据集
    for p=pp
    a1=load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    a=a1.ff
    f=[f;a];
   end
    save([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\zong1'],'f');
end   
end
end