clc;
close all;
clear all;

mode='DCE';
file=cell(1,4);
for j=1:5
file{1}='肿块p',file{2}='肿块n',file{3}='整体p',file{4}='整体n',file{5}='整体';
pp=[1:121];%共121个样本
pp([13,14,15,21,23,32,37,46,50,51,69,71,70,75,80,83,86,89,107,87,91,92,93,95,96,98,102,103,105,106,109,112,116,118 ])=[];%因图像不全等原因排除
for p=pp 
load(['E:\乳腺\我的程序\1数据\MR\',mode,'\输入腺体\原始\',num2str(j),'\in_mr',num2str(p)]);
 I=in;
 [LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH]=dwt3d(I);%三维小波变换得到八个子带
  %原始输入图像与其八个小波子带存在inm中
 inm{1}=I;
 inm{2}=LLL;inm{3}=LLH;inm{4}=HLL;inm{5}=HLH;inm{6}=LHL;inm{7}=LHH;inm{8}=HHL;inm{9}=HHH;
 %保存inm
 save(['E:\乳腺\我的程序\1数据\MR\',mode,'\输入腺体\变换\',num2str(j),'\in_mr',num2str(p)],'inm');
 end
end

