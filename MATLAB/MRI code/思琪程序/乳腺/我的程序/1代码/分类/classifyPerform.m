function [accuracy,sensitivity,specificity,auc,TP,TN,FP,FN] = classifyPerform(response,Y,decisionvalue)
% INPUTS:
% - response:预测标签
% - Y: 实际标签
% - decisionvalue:决策值   

TP = sum(response==1 & Y==1);
TN = sum(response==0 & Y==0);
FP = sum(response==1 & Y==0);
FN = sum(response==0 & Y==1);

% Computing performance
sensitivity = TP/(TP + FN);
specificity = TN/(TN + FP);
accuracy = (TP + TN)/(TP + TN + FP + FN);
auc = roc_curve(decisionvalue,Y);
end
      
function auc = roc_curve(decisionvalue,label_y)
% 要对于一个特定的分类器和测试数据集，只能得到一个分类结果，而绘制ROC曲线需一系列FPR和TPR的值
% 决策值越高，表示分类器越肯定地认为这个测试样本是正样本，我们根据每个测试样本属于正样本的概率值从大到小排序从高到低，依次将“decisionvalue”值作为阈值threshold
% 当测试样本属于正样本的概率大于或等于这个threshold时，我们认为它为正样本，否则为负样本。每次选取一个不同的threshold，我们就可以得到一组FPR和TPR，即ROC曲线上的一点。这样一来，我们一共得到了len组FPR和TPR的值（len为样本数）
    [val,ind] = sort(decisionvalue,'descend');
	roc_y = label_y(ind);
	stack_x = cumsum(roc_y == 0)/sum(roc_y ==0);
	stack_y = cumsum(roc_y == 1)/sum(roc_y == 1);
	auc = sum((stack_x(2:length(roc_y),1)-stack_x(1:length(roc_y)-1,1)).*stack_y(2:length(roc_y),1))     
%   绘制roc曲线
% 	plot(stack_x,stack_y);
%   hold on
%   plot([0,1],[0,1],'--r');
% 	xlabel('False Positive Rate');
% 	ylabel('True Positive Rate');
% 	title(['ROC curve of (AUC = ' num2str(auc) ' )']);
end