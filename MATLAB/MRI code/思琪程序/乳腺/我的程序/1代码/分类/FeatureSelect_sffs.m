function [cols] = FeatureSelect_sffs(trainlabels, traindata, testlabels, testdata)
% Function implements the sequential forward floating selection algorithm
% with the given labels and data

numfeat = []; % used for plotting output绘制输出
accuracy = []; % used for plotting output绘制输出
cols = []; % Vector for storing set of features we will use存储特征集
maxacc = 0; % Variable to store maximum accuracy our algo provides存储最大准确率
previtrmax = -1; % value < 0 to initialize loop循环标志
k = 1; % keep track of number of iterations迭代次数
% need to stop when acc doesn't improve 当accd的值不改变时停止循环
%加入特征
while (maxacc > previtrmax) % If accuracy of prediction isn't increased stop
    previtrmax = maxacc; % Assign previous max value
    featureaddresults = zeros(1,size(traindata,2)); % store result of adding each feature存储加入特征的结果
    for col = 1:length(featureaddresults)
        if (ismember(col, cols)) % If current feature in our set skip it
            continue;
        end
        newcols = cols;
        % Add new column to test resulting prediction
        newcols(end+1) = col; 
        data = traindata(:,newcols);
   model = svmtrain(trainlabels,data ,'-b 0');
 [label, accuracy,d] = svmpredict(testlabels ,testdata(:,newcols), model,'-b 0');

        % Evaluate accuracy of model
        %resultlist存储也测结果与实际是否一致，一致为1.
        resultlist = zeros(1,(length(testlabels)));
        for i = 1:length(testlabels)
            matches = (label(i) == testlabels(i));
            resultlist(1,i) = matches;
        end
        % Get precentage of rows that match between prediction and test
        % labels
        correctprct = (sum(resultlist)/size(resultlist,2)); %计算准确率
        featureaddresults(col) = correctprct;%新加入的特征的准确率
    end
    
    % If adding max feature increases accuracy add to our set of features
    %找到最大特征及其索引，cols和maxacc更新
    [val, indx] = max(featureaddresults);
    if (val > maxacc)
        cols(end+1) = indx;%加入
        maxacc = val;
    end
    %移除特征
    updated = 1; % Value to initialize while loop while循环标志
    while updated
        updated = 0;
        if (length(cols) > 1) % need atleast one vector or won't be able to predict至少一个特征
            featuresubtractresults = zeros(1,size(cols,2)); % vector for storing results存储结果
            for col = 1:length(featuresubtractresults)
                fewercols = cols;
                % remove the column from our set and evaluate
                %移除特征
                fewercols(col) = []; 
                data = traindata(:,fewercols);

   model = svmtrain(trainlabels,data,'-b 0' );
 [label, accuracy,d] = svmpredict(testlabels ,testdata(:,newcols), model,'-b 0');

                % Evaluate accuracy of model
                %resultlist存储预测结果与实际是否一致，一致为1.
                resultlist = zeros(1,(length(testlabels)));
                for i = 1:length(testlabels)
                  matches = (label(i) == testlabels(i));
                  resultlist(1,i) = matches;
                end
                %计算准确率
                correctprct = (sum(resultlist)/size(resultlist,2));
                featuresubtractresults(col) = correctprct;
            end
            
            % If max prediction from feature removal increases accuracy
            % remove from our set of features
            %找到最大特征及其索引，cols和maxacc更新
            [valr, indxr] = max(featuresubtractresults);
            if (valr > maxacc)
                maxacc = valr;
                cols(indxr) = [];%移除
                updated = 1;
            end
        end
    end
    
    % Display results after each iteration
    %显示每次迭代的结果
    %原代码
%     disp(strcat(string('After iteration '), string(k), ...
%         string(' the max value of svm is at '), string(maxacc), ...
%         string(' with the following columns: ')));%disp 显示
    %修改
    disp(strcat('After iteration ',' ', num2str(k), ...
        ' the max value of svm is at ',' ', num2str(maxacc), ...
        ' with the following columns: '));
    disp(cols);
    k = k + 1;
    numfeat(end+1) = length(cols);
    accuracy(end+1) = (maxacc);
end
