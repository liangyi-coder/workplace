%% ��ȡѵ��������Ҫ�ı�ǩ
load('features.mat');
load('labels.mat');
%  load('f_n.mat');
%% ѵ��svmģ��
svmStruct = fitcsvm(features_data,labels);


