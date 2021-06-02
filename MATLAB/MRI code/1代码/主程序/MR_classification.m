clc;
close all;
clear all;
%������ȡ�ļ�������
mode='DCE';
fname{1}='shape';
fname{2}='statistics';
fname{3}='glcm';
fname{4}='glrl';
fname{5}='glszm';
fname{6}='ngtdm';
fname{7}='tic';
%%%%%%%%%��������
data_1=[];data_0=[];%data_1��Ŷ���������%data_0�����������
for i_feature=[7]%ָ��Ҫ���Ե�������1~7��fname��
    %object 1���׿飬2�����壬3���׿�4�������
   object={1,1:4,1:4,1:4,1:4,1:4,[1,3]};%shape,ֻ����׿����,ticֻ����׿���׿�����,�������������׿飬���壬�׿�����������
    %decomposition 1~9:ԭʼ��LLL,LLH,HLL,HLH,LHL,LHH,HHL,HHH
   decomposition={1,1:9,1:9,1:9,1:9,1:9,1};%shape,tic��������С���任��ֻ��ԭʼͼ��,����������С���任����ԭʼͼ���8��decomposition
%%%%%%%%%%����������
for j=object{i_feature}
    if j==1
file{1}='�׿�p',file{2}='�׿�p��LLL��',file{3}='�׿�p��LLH��',file{4}='�׿�p��HLL��',file{5}='�׿�p��HLH��',file{6}='�׿�p��LHL��',file{7}='�׿�p��LHH��',file{8}='�׿�p��HHL��',file{9}='�׿�p��HHH��';
    elseif j==2
 file{1}='����',file{2}='���壨LLL��',file{3}='���壨LLH��',file{4}='���壨HLL��',file{5}='���壨HLH��',file{6}='���壨LHL��',file{7}='���壨LHH��',file{8}='���壨HHL��';file{9}='���壨HHH��';
    elseif j==3
file{1}='�׿��',file{2}='�׿�LLL��',file{3}='�׿�LLH��',file{4}='�׿�HLL��',file{5}='�׿�HLH��',file{6}='�׿�LHL��',file{7}='�׿�LHH��',file{8}='�׿�HHL��',file{9}='�׿�HHH��';
elseif j==4
 file{1}='�����',file{2}='����LLL��',file{3}='����LLH��',file{4}='����HLL��',file{5}='����HLH��',file{6}='����LHL��',file{7}='����LHH��',file{8}='����HHL��',file{9}='����HHH��';
 end
for i1=decomposition{i_feature}
    load([ 'D:\˼������\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\1\zong1'])
    data_1=[data_1,f];
    load([ 'D:\˼������\����\�ҵĳ���\1����\MR\',mode,'\',fname{i_feature},'\',file{i1},'\0\zong1'])
    data_0=[data_0,f];
end
end
end
%�����������ֱ�ȡ�꣬�ϲ���data��ÿ�д���һ��������ÿ��Ϊһ������
[M1 N1] = size(data_1);%M1������������
% data_0=data_0(1:M1,:);%ʹ��������������ͬ
[M2 N1] = size(data_0);%M2������������
data=[data_1;data_0]
[data,mean1,variance1]=zscore(data);%����������׼��
label = [ones(M1, 1); zeros(M2, 1)];% labelΪ��ǩ,��������*1����ǩΪ1��0������
len=length(label);%����������
index=[1:len]';
cv=10;%������֤����
 %%%%%%%%%%%%%%������֤
  for i = 1:cv 
   index_1= index(1:M1);index_0= index(M1+1:end);
   test_ind_1  = index_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');%ȡ����������1/cv������Լ�
   test_ind_0 = index_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');%ȡ����������1/cv������Լ�
   test_ind = [test_ind_1;test_ind_0 ];%���Լ�����
   train_ind = index;
   train_ind(test_ind) = [];%ѵ�������������������ų����Լ���
   testData=data(test_ind ,:);
   testLabel=label(test_ind );
   trainData=data(train_ind,:);
   trainLabel=label(train_ind);
[cols{i}]=FeatureSelect_sffs(trainLabel,trainData,testLabel,testData);%������֤Ƕ��sffs��ÿ��ѡ����Ӧ��Ч��������cols
data1=data(:,cols{i});%ʹ��ѡ�����Ч����
traindata=data1(train_ind,:);
testdata=data1(test_ind,:);
% ѵ��ģ�Ͳ�Ԥ����࣬�����ز�����libsvm���߰�
 model = svmtrain(trainLabel,traindata );
 %��һ�������Ԥ���ǩ�������ڶ��������׼ȷ������������׼ȷ�ʣ��������⣩��������ƽ�����ϵ�����ع����⣩��������Ϊ����ֵ���߸�������������
[predicted_label, accuracy,decisionvalue] = svmpredict(testLabel ,testdata, model);
%������֤�����󣬵õ�����������Ԥ���ǩ�����ֵ
predicted_label_all(test_ind)=predicted_label;
decisionvalue_all(test_ind)=decisionvalue;
 end
[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(predicted_label_all',label,decisionvalue_all');%��������ָ��
aresult=[accuracy,sensitivity,specificity,auc,TP,TN,FP,FN];
%��aresult�����в鿴��������cols�����鿴����ѡ����
