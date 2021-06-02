clear;
clc;

LabelPath1 = 'F:\贵医X线和MRI区域分割\RripleNegative\丁小秀22848509\mask\';
fileExt1 = '*.png'; %待读取图像的后缀名

LabelPath2 = 'F:\贵医X线和MRI区域分割\RripleNegative\丁小秀22848509\dcm2png\';
fileExt2 = '*.png';

%获取多所有图像
files1 = dir(fullfile(LabelPath1,fileExt1));
len1 = size(files1,1);
files2 = dir(fullfile(LabelPath2,fileExt2));
len2 = size(files2,1);

if len1 ~= len2
    fprintf('图片不匹配');
end

%遍历每一幅图像
for i = 1:len1
    %提取图像
    fileName1 = strcat(LabelPath1,files1(i).name);
    file1 = imread(fileName1);
    file1 = im2double(file1*65535);
    
    fileName2 = strcat(LabelPath2,files2(i).name);
    file2 = imread(fileName2);
    file2 = im2double(file2);
    %提取ROI
    ROI = file1.*file2;    
    
    save_path = strcat('F:\贵医X线和MRI区域分割\RripleNegative\丁小秀22848509\ROI\',files1(i).name,'.png');
    imwrite(ROI,save_path);
end
