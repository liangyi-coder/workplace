% function [bestacc,bestAUC,bestsensitivity,bestspecificity,bestc,bestg] = SVMcg(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
function [bestacc,bestc,bestg] = SVMcg(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep,indices )
% train_label: 训练集标签,要求与libsvm工具箱中要求一致.
% train: 训练集,要求与libsvm工具箱中要求一致.
% cmin: 惩罚参数c的变化范围的最小值(取以2为底的对数后),即 c_min = 2^(cmin).默认为 -5
% cmax: 惩罚参数c的变化范围的最大值(取以2为底的对数后),即 c_max = 2^(cmax).默认为 5
% gmin: 参数g的变化范围的最小值(取以2为底的对数后),即 g_min = 2^(gmin).默认为 -5
% gmax: 参数g的变化范围的最小值(取以2为底的对数后),即 g_min = 2^(gmax).默认为 5
% v: cross validation的参数,即给测试集分为几部分进行cross validation.默认为 3
% cstep: 参数c步进的大小.默认为 1
% gstep: 参数g步进的大小.默认为 1  
% accstep: 最后显示准确率图时的步进大小. 默认为 1.5

% 将c和g划分网络，X中记录c，Y中记录g；
% c的个数确定X，Y的列数，g的个数确定X，Y的行数
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
% cg中将要记录的是对应不同的c和g的K-CV过程准确率
cg = zeros(m,n);
% 相关变量的初始化
bestc = 0;
bestg = 0;
bestacc = 0;
basenum = 2;
for i = 1:m
    for j = 1:n
       % libsvm-mat工具箱采用-v参数就可以直接实现K-CV方法
        cmd = ['-v ',num2str(v),' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) )];
        cg(i,j) = svmtrain(train_label, train, cmd);
       
        %%%%%分组%%%%%%%
%         cmd = [' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) )];
        label=train_label;
        data=train;

%         num=length(label);
% len = length(label);
% rng(1);
% rand_ind= randperm(length(label)); 
 
% indices = crossvalind('Kfold',label,v);
% rand_ind_1= rand_ind(1:M1);rand_ind_0= rand_ind(M1+1:end);
% AUC1=[];sensitivity1=[];specificity1=[];accuracy1=[];
% for i = 1:v % Cross training : folding
% 
% %  test_ind = (indices == i);train_ind = ~test_ind ;

%   test_ind_1 = rand_ind_1([floor((i-1)*M1/cv)+1:floor(i*M1/cv)]');
%    test_ind_0 = rand_ind_0([floor((i-1)*M2/cv)+1:floor(i*M2/cv)]');
%   test_ind = [test_ind_1 ,test_ind_0 ];

%  test_ind = rand_ind([floor((i-1)*len/v)+1:floor(i*len/v)]');
%   train_ind = [1:len]';
%   train_ind(test_ind) = [];
% 
% 
%  testData=data(test_ind ,:);
%     testLabel=label(test_ind );
%     trainData=data(train_ind,:);
%     trainLabel=label(train_ind);
% 
% 
%         model = svmtrain(trainLabel, trainData, cmd );
%        [predict_label, accuracy,d] = svmpredict(testLabel ,testData, model); 
%        accuracy1(end+1)= accuracy(1);
% 
%         end
% 
%        cg(i,j)=mean(accuracy1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end
        % 选取能够达到最高验证分类准确率中参数c最小的那组c和g作为最佳的参数
        % 如果对应的最小的c有多组g,就选取搜索到的第一组c和g作为最佳的参数
        eps = 10^(-4);
        if ( abs( cg(i,j) - bestacc) <= eps && bestc > basenum^X(i,j) )
            bestacc = cg(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
%             bestAUC=AUC;
%             bestsensitivity=sensitivity;
%             bestspecificity=specificity;
        end
        
    end
end

% 图形显示不同c和g下的准确率
% 等高线绘制函数
% figure;
% [C,h] = contour(X,Y,cg,1:accstep:100);
% clabel(C,h,'FontSize',10,'Color','r');
% xlabel('log2c','FontSize',10);
% ylabel('log2g','FontSize',10);
% grid on;
% title('参数选择结果图(等高线)');
% figure;
% [C_3,h_3] = contour3(X,Y,cg,1:accstep:100);
%surface(X,Y,cg);
% xlabel('log2c','FontSize',10);
% ylabel('log2g','FontSize',10);
% zlabel('Accurancy(%)','FontSize',10);
% title('参数选择结果图(3D视图)');


function [AUC,sensitivity,specificity,accuracy] = calcPerformMetrics1(response,Y,thresh)
% -------------------------------------------------------------------------
% function [AUC,sensitivity,specificity,accuracy] = calcPerformMetrics(response,outcome,thresh)
% -------------------------------------------------------------------------
% DESCRIPTION: 
% This function computes AUC, sensitivity, specificity and accuracy metrics
% given a modle response, outcome and threshold. This function uses a fast 
% implementation of AUC calculation by Enric Junqu茅 de Fortuny that is
% available at: <http://www.mathworks.com/matlabcentral/fileexchange/41258-faster-roc-auc>
% -------------------------------------------------------------------------
% INPUTS:
% - response: Column vector of size [nInst X 1], specifying the 
%             multivariable response for all instances (nInst is the total 
%             number of instances).
% - Y: Column vector of size [nInst X 1] specifying the outcome status 
%      (1 or 0) for all instances.
% - thresh: Threshold used to calculate sensitivity, specificity and
%           accuracy metrics (typically 0 for logistic regression).
% -------------------------------------------------------------------------
% OUTPUTS:
% - AUC
% - Sensitivity
% - Specificity
% - Accuracy
% -------------------------------------------------------------------------
% AUTHOR(S): 
% - Martin Vallieres <mart.vallieres@gmail.com>
% - Enric Junqu茅 de Fortuny (fastAUC.cpp)
% -------------------------------------------------------------------------
% HISTORY:
% - Creation: May 2015
%--------------------------------------------------------------------------
% STATEMENT:
% This file is part of <https://github.com/mvallieres/radiomics/>, 
% a package providing MATLAB programming tools for radiomics analysis.
% --> Copyright (C) 2015  Martin Vallieres
%
%    This package is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This package is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this package.  If not, see <http://www.gnu.org/licenses/>.
%
%    _______________________________________________________________
%
% --> Copyright (c) 2013, Enric Junqu茅 de Fortuny
%     All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%     * Redistributions of source code must retain the above copyright 
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in 
%       the documentation and/or other materials provided with the distribution
%      
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.
% -------------------------------------------------------------------------


% Computing AUC
try
    AUC = fastAUC(Y,response,1);
catch
    try
        compileFastAUC('Linux')
        AUC = fastAUC(Y,response,1);
    catch
        try
            [~,~,~,AUC] = perfcurve(Y,response,1);
        catch
            AUC = 0.5;
            fprintf('\nSomething went wrong with the AUC calculations\n')
        end 
    end
end

% Classifications
TP = sum(response>=thresh & Y==1);
TN = sum(response<thresh & Y==0);
FP = sum(response>=thresh & Y==0);
FN = sum(response<thresh & Y==1);

% Computing performance metrics
sensitivity = TP/(TP + FN);
specificity = TN/(TN + FP);
accuracy = (TP + TN)/(TP + TN + FP + FN);

% Validation check of metrics
AUC(isnan(AUC)) = 0.5;
sensitivity(isnan(sensitivity)) = 0;
specificity(isnan(specificity)) = 0;
accuracy(isnan(accuracy)) = 0;

