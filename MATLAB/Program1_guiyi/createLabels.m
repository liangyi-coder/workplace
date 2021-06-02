clear;
clc;

LabelPath1 = 'F:\��ҽX�ߺ�MRI����ָ�\RripleNegative\��С��22848509\mask\';
fileExt1 = '*.png'; %����ȡͼ��ĺ�׺��

LabelPath2 = 'F:\��ҽX�ߺ�MRI����ָ�\RripleNegative\��С��22848509\dcm2png\';
fileExt2 = '*.png';

%��ȡ������ͼ��
files1 = dir(fullfile(LabelPath1,fileExt1));
len1 = size(files1,1);
files2 = dir(fullfile(LabelPath2,fileExt2));
len2 = size(files2,1);

if len1 ~= len2
    fprintf('ͼƬ��ƥ��');
end

%����ÿһ��ͼ��
for i = 1:len1
    %��ȡͼ��
    fileName1 = strcat(LabelPath1,files1(i).name);
    file1 = imread(fileName1);
    file1 = im2double(file1*65535);
    
    fileName2 = strcat(LabelPath2,files2(i).name);
    file2 = imread(fileName2);
    file2 = im2double(file2);
    %��ȡROI
    ROI = file1.*file2;    
    
    save_path = strcat('F:\��ҽX�ߺ�MRI����ָ�\RripleNegative\��С��22848509\ROI\',files1(i).name,'.png');
    imwrite(ROI,save_path);
end
