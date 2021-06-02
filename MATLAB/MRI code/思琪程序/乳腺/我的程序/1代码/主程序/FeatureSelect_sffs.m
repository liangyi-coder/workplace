function [cols] = FeatureSelect_sffs(trainlabels, traindata, testlabels, testdata)
% Function implements the sequential forward floating selection algorithm
% with the given labels and data

numfeat = []; % used for plotting output�������
accuracy = []; % used for plotting output�������
cols = []; % Vector for storing set of features we will use�洢������
maxacc = 0; % Variable to store maximum accuracy our algo provides�洢���׼ȷ��
previtrmax = -1; % value < 0 to initialize loopѭ����־
k = 1; % keep track of number of iterations��������
% need to stop when acc doesn't improve ��accd��ֵ���ı�ʱֹͣѭ��
%��������
while (maxacc > previtrmax) % If accuracy of prediction isn't increased stop
    previtrmax = maxacc; % Assign previous max value
    featureaddresults = zeros(1,size(traindata,2)); % store result of adding each feature�洢���������Ľ��
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
        %resultlist�洢Ҳ������ʵ���Ƿ�һ�£�һ��Ϊ1.
        resultlist = zeros(1,(length(testlabels)));
        for i = 1:length(testlabels)
            matches = (label(i) == testlabels(i));
            resultlist(1,i) = matches;
        end
        % Get precentage of rows that match between prediction and test
        % labels
        correctprct = (sum(resultlist)/size(resultlist,2)); %����׼ȷ��
        featureaddresults(col) = correctprct;%�¼����������׼ȷ��
    end
    
    % If adding max feature increases accuracy add to our set of features
    %�ҵ������������������cols��maxacc����
    [val, indx] = max(featureaddresults);
    if (val > maxacc)
        cols(end+1) = indx;%����
        maxacc = val;
    end
    %�Ƴ�����
    updated = 1; % Value to initialize while loop whileѭ����־
    while updated
        updated = 0;
        if (length(cols) > 1) % need atleast one vector or won't be able to predict����һ������
            featuresubtractresults = zeros(1,size(cols,2)); % vector for storing results�洢���
            for col = 1:length(featuresubtractresults)
                fewercols = cols;
                % remove the column from our set and evaluate
                %�Ƴ�����
                fewercols(col) = []; 
                data = traindata(:,fewercols);

   model = svmtrain(trainlabels,data,'-b 0' );
 [label, accuracy,d] = svmpredict(testlabels ,testdata(:,newcols), model,'-b 0');

                % Evaluate accuracy of model
                %resultlist�洢Ԥ������ʵ���Ƿ�һ�£�һ��Ϊ1.
                resultlist = zeros(1,(length(testlabels)));
                for i = 1:length(testlabels)
                  matches = (label(i) == testlabels(i));
                  resultlist(1,i) = matches;
                end
                %����׼ȷ��
                correctprct = (sum(resultlist)/size(resultlist,2));
                featuresubtractresults(col) = correctprct;
            end
            
            % If max prediction from feature removal increases accuracy
            % remove from our set of features
            %�ҵ������������������cols��maxacc����
            [valr, indxr] = max(featuresubtractresults);
            if (valr > maxacc)
                maxacc = valr;
                cols(indxr) = [];%�Ƴ�
                updated = 1;
            end
        end
    end
    
    % Display results after each iteration
    %��ʾÿ�ε����Ľ��
    %ԭ����
%     disp(strcat(string('After iteration '), string(k), ...
%         string(' the max value of svm is at '), string(maxacc), ...
%         string(' with the following columns: ')));%disp ��ʾ
    %�޸�
    disp(strcat('After iteration ',' ', num2str(k), ...
        ' the max value of svm is at ',' ', num2str(maxacc), ...
        ' with the following columns: '));
    disp(cols);
    k = k + 1;
    numfeat(end+1) = length(cols);
    accuracy(end+1) = (maxacc);
end
