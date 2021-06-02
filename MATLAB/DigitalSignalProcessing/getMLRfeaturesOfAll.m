%% �õ�training-a��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-a\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_a=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_a{j} = voice; 
end

features_data_a = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_a{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_a(i,:) = features;
    fprintf(['---train_data_a ' num2str(i) ' ��������ȡ���.\n']);
end

%% �õ�training-b��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-b\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_b=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_b{j} = voice; 
end

features_data_b = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_b{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_b(i,:) = features;
    fprintf(['---train_data_b ' num2str(i) ' ��������ȡ���.\n']);
end

%% �õ�training-c��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-c\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_c=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_c{j} = voice; 
end

features_data_c = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_c{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_c(i,:) = features;
    fprintf(['---train_data_c ' num2str(i) ' ��������ȡ���.\n']);
end

%% �õ�training-d��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-d\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_d=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_d{j} = voice; 
end

features_data_d = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_d{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_d(i,:) = features;
    fprintf(['---train_data_d ' num2str(i) ' ��������ȡ���.\n']);
end

%% �õ�training-e��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-e\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_e=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_e{j} = voice; 
end

features_data_e = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_e{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_e(i,:) = features;
    fprintf(['---train_data_e ' num2str(i) ' ��������ȡ���.\n']);
end

%% �õ�training-f��MLR����
file_path = 'C:\Users\liangyi\workplace\MATLAB\sample2016\training-f\';

voice_path_list = dir(strcat(file_path,'*.wav'));%��ȡ���ļ���������wav��ʽ����Ƶ  
len = length(voice_path_list);%��ȡ��Ƶ������ 
train_data_f=cell(1,len);
for j = 1:len %��һ��ȡ��Ƶ 
    voice_name = voice_path_list(j).name;% ��Ƶ��  
    [voice,fs]=audioread(strcat(file_path,voice_name));  
%     PCG_resampled  = resample(voice,springer_options.audio_Fs,fs); % resample to springer_options.audio_Fs (1000 Hz)
%     train_data_a{j}=PCG_resampled;
    train_data_f{j} = voice; 
end

features_data_f = zeros(len,7);
for i = 1:len
%     [assigned_states] = runSpringerSegmentationAlgorithm(train_data_a{i}, springer_options.audio_Fs, Springer_B_matrix, Springer_pi_vector, Springer_total_obs_distribution, false); % obtain the locations for S1, systole, s2 and diastole
%     [S1, S2, S3, S4] = mergeSameSegment(assigned_states,train_data_a{i});%Running mergeSameSegment.m to obtain four merged records of the same assigned_state
    features  = extractMLRfeatures(train_data_f{i});% Running extractFeaturesFromHsIntervals.m to obtain the features for normal/abnormal heart sound classificaiton
    features_data_f(i,:) = features;
    fprintf(['---train_data_f ' num2str(i) ' ��������ȡ���.\n']);
end

features = [features_data_a; features_data_b; features_data_c; features_data_d; features_data_e; features_data_f];