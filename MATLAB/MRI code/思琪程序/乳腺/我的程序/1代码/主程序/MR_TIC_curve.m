clc;
close all;
clear all;
%n为序列图像中病灶最明显的层数
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
%k为各病例MASK序列的图像张数
k(1:121)=78;k(25)=76;k(48)=68;k([88,104])=66;k([113,114])=70;
k([18,23,28,62,77,100])=74;
k([75,96,102])=150;k([80,92])=160;
pp=[1:121];%共121个样本
pp([13,14,15,21,23,25,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,107,109,112,116,118 ])=[];%因图像不全等原因排除
val_p=[];val_n=[];%val_p存病灶侧（positive）TIC曲线（1*9，MASK+8个增强序列共9个时间点对应的病灶区域灰度平均值），val_n存对侧（negative）TIC曲线
%%%%%%%%%%%%%%%输入MASK序列
 for p=[121]
     load(['E:\乳腺\我的程序\1数据\MR\DCE\输入腺体\原始\grow\in_mr',num2str(p)]);%病灶区域掩模
 n0=n(p);%以病灶最明显一层为基准取13张图片，大致可容纳所有肿块部分
 for i1=-6:6
     n1=n0+i1;
if ismember(p,[ 69,71,83,91,93,95,98,112,116,118])
 fileform =[ 'I:\乳腺病例\分类\MASK\',num2str(p),'\*.dcm'];
filepathsrc = ['I:\乳腺病例\分类\MASK\',num2str(p),'\'];
file_outord = dir(fileform);
c1=struct2cell(file_outord);
c2=c1{1,n1};
I = dicomread([filepathsrc,c2]);
elseif ismember(p,[106])
     I = dicomread(['I:\乳腺病例\分类\MASK\',num2str(p),'\',num2str(n1),'.dcm']);%读取图像 
elseif ismember(p,[ 75,80,92,96,102])
     I = dicomread(['I:\乳腺病例\分类\DCE\',num2str(p),'\',num2str(n1),'_',num2str((9*(n1-1))),'.dcm']);
     I=imresize(imrotate(I,180),[1024,1024]);
else
  try
    I = dicomread(['I:\乳腺病例\分类\MASK\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%读取图像 
    catch
     I1 = dicomread(['I:\乳腺病例\分类\DCE\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%读取图像 
     I2 = dicomread(['I:\乳腺病例\分类\Subtraction\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%读取图像 
     I=I1-I2;
    end
end
[M,N]=size(I);
I =double(I);
m_fil=5;sigma=0.1;
H=fspecial('gaussian',[m_fil m_fil],sigma);
I=imfilter(I,H,'same');
I3(:,:,i1+7)=I;%I3为MASK序列含病灶在内的13张（1024*1024*13）
end    
val_p1=I3(logical(in));%取病灶部分所有像素的灰度值
val_n1=I3(fliplr(logical(in)));%取病灶在对侧的对应部分所有像素的灰度值
val_p(1)=mean(val_p1);%均值即为病灶侧TIC曲线第一个时间点的值
val_n(1)=mean(val_n1);%均值即为对侧TIC曲线第一个时间点的值     
     
%%%%%%%%%%%%%%%输入DCE8个序列     
 for seq=0:7
  n0=n(p);
for i1=-6:6
    n1=n0+i1+seq*k(p);
if ismember(p,[ 69,71,83,91,93,95,98,106,112,116,118])
fileform =[ 'I:\乳腺病例\分类\DCE\',num2str(p),'\*.dcm'];
filepathsrc = ['I:\乳腺病例\分类\DCE\',num2str(p),'\'];
file_outord = dir(fileform);
c1=struct2cell(file_outord);
c2=c1{1,n1};
I = dicomread([filepathsrc,c2]);
elseif ismember(p,[ 75,80,92,96,102])
   I = dicomread(['I:\乳腺病例\分类\DCE\',num2str(p),'\',num2str(n1),'_',num2str((9*(n1-k(p)*seq-1))+(seq)),'.dcm']);
   I=imresize(imrotate(I,180),[1024,1024]);
else
    try
    I = dicomread(['I:\乳腺病例\分类\DCE\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%读取图像 
    catch
     I1 = dicomread(['I:\乳腺病例\分类\MASK\',num2str(p),'\',num2str(n0+i1),'_',num2str(n0+i1-1),'.dcm']);%读取图像 
     I2 = dicomread(['I:\乳腺病例\分类\Subtraction\',num2str(p),'\',num2str(n1),'_',num2str(n1-1),'.dcm']);%读取图像 
     I=I1+I2;
    end
end
I =double(I);
m_fil=5;sigma=0.1;
H=fspecial('gaussian',[m_fil m_fil],sigma);
I=imfilter(I,H,'same');
I3(:,:,i1+7)=I;%I3为DCE序列含病灶在内的13张（1024*1024*13）
end
val_pi=I3(logical(in));%取病灶部分所有像素的灰度值
val_ni=I3(fliplr(logical(in)));%取病灶在对侧的对应部分所有像素的灰度值
val_p(end+1)=mean(val_pi);%均值即为病灶侧TIC曲线第seq+2（2~9）个点的值
val_n(end+1)=mean(val_ni);%均值即为对侧TIC曲线第seq+2（2~9）一个点的值   
 end
% 显示TIC曲线 
     P_p=polyfit(1:9,val_p,7);%7次多项式拟合
     P_n=polyfit(1:9,val_n,7);
     L=1:0.01:9;
     C_p=polyval(P_p,L);
     C_n=polyval(P_n,L);
     figure
     plot(L,C_p,'-');hold on
     plot(L,C_n,'--');
     legend('positive TIC ','negative TIC','Location','SouthEast');

%保存病灶侧和对侧TIC曲线
 val=val_p;
 save(['E:\乳腺\我的程序\1数据\MR\DCE\输入腺体\原始\TIC_p\in_mr',num2str(p)],'val');
 val=val_n;
 save(['E:\乳腺\我的程序\1数据\MR\DCE\输入腺体\原始\TIC_n\in_mr',num2str(p)],'val');
     end  