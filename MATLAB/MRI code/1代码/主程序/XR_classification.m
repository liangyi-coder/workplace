clc;
close all;
clear all;
%特征提取文件夹名称
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
%%%%%%%%%加载数据
data_1=[];data_0=[];%data_1存放恶性样本，%data_0存放良性样本
for i_feature=[1:8]%指定要测试的特征（1~8见fname）
    %object 1：肿块，2：整体，3：肿块差，4：整体差
object={1,1:4,1:4,1:4,1:4,1:4,[1,3],1:4};%shape只针对肿块计算,wld只针对肿块和肿块差，计算其他特征基于肿块，整体，肿块差和整体差计算
    %decomposition 1~5:原始，LL，LH，HL，HH 
decomposition={1,1:5,1:5,1:5,1:5,1:5,1:5,1:5,};%shape特征不做小波变换，只用原始图像,其余特征做小波变换，有原始图像和4个decomposition
%%%%%%%%%%读特征数据
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
    load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\1\zong1'])
    data_1=real(data_1);
    data_1=[data_1,f];
    load([ 'D:\乳腺\我的程序\1数据\XR\',mode,'\',fname{i_feature},'\',file{i1},'\0\zong1'])
    data_0=real(data_0);
    data_0=[data_0,f];
end
end
end
%良恶性样本分别取完，合并到data：每行代表一个样本，每列为一个特征
[M1 N1] = size(data_1);
% data_0=data_0(1:M1,:);%使良恶性样本数相同
[M2 N1] = size(data_0);
data=[data_1;data_0]
[data,mean1,variance1]=zscore(data);%特征向量标准化
label = [ones(M1, 1); zeros(M2, 1)];% label为标签,样本个数*1，标签为1与0这两类
len=length(label);%所有样本数
index=[1:len]';
cv=10;%交叉验证折数
 %%%%%%%%%%%%%%交叉验证
  for i = 1:cv 
   index_1= index(1:M1);index_0= index(M1+1:end);
   test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');%取恶性样本的1/cv进入测试集
   test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');%取良性样本的1/cv进入测试集
   test_ind = [test_ind_1;test_ind_0 ];%测试集索引
   train_ind = index;
   train_ind(test_ind) = [];%训练集索引（整体样本排除测试集）
   testData=data(test_ind ,:);
   testLabel=label(test_ind );
   trainData=data(train_ind,:);
   trainLabel=label(train_ind);
[cols{i}]=FeatureSelect_sffs(trainLabel,trainData,testLabel,testData);%交叉验证嵌套sffs，每折选出相应有效特征存入cols
data1=data(:,cols{i});%使用选择的有效特征
traindata=data1(train_ind,:);
testdata=data1(test_ind,:);
% 训练模型并预测分类，需下载并编译libsvm工具包
 model = svmtrain(trainLabel,traindata );
  %第一个输出是预测标签向量。第二个输出是准确率向量，包括准确率（分类问题），均方误差，平方相关系数（回归问题）。第三个为决策值或者概率评估的向量
[predicted_label, accuracy,decisionvalue] = svmpredict(testLabel ,testdata, model);
%交叉验证结束后，得到所有样本的预测标签与决策值
predicted_label_all(test_ind)=predicted_label;
decisionvalue_all(test_ind)=decisionvalue;
        end
[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all');%计算评价指标
aresult=[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN];
%在aresult变量中查看分类结果，cols变量查看特征选择结果

