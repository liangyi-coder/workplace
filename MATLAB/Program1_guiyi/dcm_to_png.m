clear ;close all;clc;
SamplePath1 =  'F:\贵医X线和MRI区域分割\RripleNegative\丁小秀22848509\\dcm\';  
fileExt = '*.dcm';  %待读取图像的后缀名
%获取所有路径
files = dir(fullfile(SamplePath1,fileExt)); 
len1 = size(files,1);
%遍历路径下每一幅图像
for i=1:len1
   fileName=strcat(SamplePath1,files(i).name); 
   dcm=dicomread(fileName);
%    figure,imshow(dcm,[]);
   dcm=double(dcm); % 转为double方便后续处理
   lv=min(dcm(:));
   uv=max(dcm(:));
   dcmIM=(dcm - lv)/(uv - lv);
   fileName1=strcat('F:\贵医X线和MRI区域分割\RripleNegative\丁小秀22848509\dcm2png\',files(i).name);
   fileName1(end-3:end)=[];
   fileName2=strcat(fileName1,'.png'); 
   imwrite(dcmIM,fileName2);
end
