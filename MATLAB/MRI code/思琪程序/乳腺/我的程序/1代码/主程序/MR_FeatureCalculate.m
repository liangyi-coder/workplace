clc;
close all;
clear all;
%恶性及良性样本的序号
malignent=[1,2,3,4,5,6,8,9,10,11,12,16,19,20,22,24,25,26,49,52,53,55,58,64,65,67,68,72,73,74,76,77,78,79,81,82,84,85];
benign=[7,17,18,27,28,29,30,31,33,34,35,36,38,39,40,41,42,43,44,45,47,48,54,56,57,59,60,61,62,63,66,88,90,97,99,100,101,104,108,110,111,113,114,115,117,119,120,121];
c_10=zeros(1,121),c_10(malignent)=1;%良性样本存储在文件夹0下，恶性样本存储在文件夹1下
%特征存储文件夹名称
mode='DCE';
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
object={1,1:5,1:5,1:5,1:5,1:5};%shape只针对肿块计算,其他特征基于肿块，整体，肿块差和整体差计算
decomposition={1,1:9,1:9,1:9,1:9,1:9};%shape,特征不做小波变换，只用原始图像,其余特征做小波变换，有原始图像和8个decomposition
i_feature=2;%指定要计算的特征（1~6见fname）
for j=object{i_feature}
    if j==1
file{1}='肿块p',file{2}='肿块p（LLL）',file{3}='肿块p（LLH）',file{4}='肿块p（HLL）',file{5}='肿块p（HLH）',file{6}='肿块p（LHL）',file{7}='肿块p（LHH）',file{8}='肿块p（HHL）',file{9}='肿块p（HHH）';
    elseif j==2
file{1}='肿块n',file{2}='肿块n（LLL）',file{3}='肿块n（LLH）',file{4}='肿块n（HLL）',file{5}='肿块n（HLH）',file{6}='肿块n（LHL）',file{7}='肿块n（LHH）',file{8}='肿块n（HHL）',file{9}='肿块n（HHH）';
elseif j==3
file{1}='整体p',file{2}='整体p（LLL）',file{3}='整体p（LLH）',file{4}='整体p（HLL）',file{5}='整体p（HLH）',file{6}='整体p（LHL）',file{7}='整体p（LHH）',file{8}='整体p（HHL）',file{9}='整体p（HHH）';
elseif j==4
file{1}='整体n',file{2}='整体n（LLL）',file{3}='整体n（LLH）',file{4}='整体n（HLL）',file{5}='整体n（HLH）',file{6}='整体n（LHL）',file{7}='整体n（LHH）',file{8}='整体n（HHL）',file{9}='整体n（HHH）';
elseif j==5
file{1}='整体',file{2}='整体（LLL）',file{3}='整体（LLH）',file{4}='整体（HLL）',file{5}='整体（HLH）',file{6}='整体（LHL）',file{7}='整体（LHH）',file{8}='整体（HHL）',file{9}='整体（HHH）';
    end
pp=[1:121];%共121个样本
pp([13,14,15,21,23,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,109,112,116,118 ])=[];%因图像不全等原因排除
%%%%%%%%%%特征计算
for p=pp 
load(['E:\乳腺\我的程序\1数据\MR\',mode,'\输入腺体\变换\',num2str(j),'\in_mr',num2str(p)]);
 % 读入in，1*9 cell ，分别为原始，LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH 图像
for i1=decomposition{i_feature}
   I=inm{i1};%待计算特征的三维图像
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
save([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c_10(p)),'\',num2str(p)],'ff');
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
    file{1}='肿块p',file{2}='肿块p（LLL）',file{3}='肿块p（LLH）',file{4}='肿块p（HLL）',file{5}='肿块p（HLH）',file{6}='肿块p（LHL）',file{7}='肿块p（LHH）',file{8}='肿块p（HHL）',file{9}='肿块p（HHH）';
    a1=load([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    file{1}='肿块n',file{2}='肿块n（LLL）',file{3}='肿块n（LLH）',file{4}='肿块n（HLL）',file{5}='肿块n（HLH）',file{6}='肿块n（LHL）',file{7}='肿块n（LHH）',file{8}='肿块n（HHL）',file{9}='肿块n（HHH）';
    a2=load([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='肿块差',file{2}='肿块差（LLL）',file{3}='肿块差（LLH）',file{4}='肿块差（HLL）',file{5}='肿块差（HLH）',file{6}='肿块差（LHL）',file{7}='肿块差（LHH）',file{8}='肿块差（HHL）',file{9}='肿块差（HHH）';
    save([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
    
    file{1}='整体p',file{2}='整体p（LLL）',file{3}='整体p（LLH）',file{4}='整体p（HLL）',file{5}='整体p（HLH）',file{6}='整体p（LHL）',file{7}='整体p（LHH）',file{8}='整体p（HHL）',file{9}='整体p（HHH）';
    a1=load([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    file{1}='整体n',file{2}='整体n（LLL）',file{3}='整体n（LLH）',file{4}='整体n（HLL）',file{5}='整体n（HLH）',file{6}='整体n（LHL）',file{7}='整体n（LHH）',file{8}='整体n（HHL）',file{9}='整体n（HHH）';
    a2=load([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    b1=a1.ff
    b2=a2.ff
    ff=abs(b1-b2);
    file{1}='整体差',file{2}='整体差（LLL）',file{3}='整体差（LLH）',file{4}='整体差（HLL）',file{5}='整体差（HLH）',file{6}='整体差（LHL）',file{7}='整体差（LHH）',file{8}='整体差（HHL）',file{9}='整体差（HHH）';
    save([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)],'ff');
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
file{1}='肿块p',file{2}='肿块p（LLL）',file{3}='肿块p（LLH）',file{4}='肿块p（HLL）',file{5}='肿块p（HLH）',file{6}='肿块p（LHL）',file{7}='肿块p（LHH）',file{8}='肿块p（HHL）',file{9}='肿块p（HHH）';
    elseif j==2
 file{1}='整体',file{2}='整体（LLL）',file{3}='整体（LLH）',file{4}='整体（HLL）',file{5}='整体（HLH）',file{6}='整体（LHL）',file{7}='整体（LHH）',file{8}='整体（HHL）',file{9}='整体（HHH）';
elseif j==3
 file{1}='肿块差',file{2}='肿块差（LLL）',file{3}='肿块差（LLH）',file{4}='肿块差（HLL）',file{5}='肿块差（HLH）',file{6}='肿块差（LHL）',file{7}='肿块差（LHH）',file{8}='肿块差（HHL）',file{9}='肿块差（HHH）';
elseif j==4
 file{1}='整体差',file{2}='整体差（LLL）',file{3}='整体差（LLH）',file{4}='整体差（HLL）',file{5}='整体差（HLH）',file{6}='整体差（LHL）',file{7}='整体差（LHH）',file{8}='整体差（HHL）',file{9}='整体差（HHH）';
    end
for i1=decomposition{i_feature}
    f=[];%存储合并后的数据集
    for p=pp
    a1=load([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\',num2str(p)]);
    a=a1.ff
    f=[f;a];
   end
     save([ 'E:\乳腺\我的程序\1数据\MR\',mode,'\',fname{i_feature},'\',file{i1},'\',num2str(c1),'\zong1'],'f');
end   
end
end