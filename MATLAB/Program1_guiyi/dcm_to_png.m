clear ;close all;clc;
SamplePath1 =  'F:\��ҽX�ߺ�MRI����ָ�\RripleNegative\��С��22848509\\dcm\';  
fileExt = '*.dcm';  %����ȡͼ��ĺ�׺��
%��ȡ����·��
files = dir(fullfile(SamplePath1,fileExt)); 
len1 = size(files,1);
%����·����ÿһ��ͼ��
for i=1:len1
   fileName=strcat(SamplePath1,files(i).name); 
   dcm=dicomread(fileName);
%    figure,imshow(dcm,[]);
   dcm=double(dcm); % תΪdouble�����������
   lv=min(dcm(:));
   uv=max(dcm(:));
   dcmIM=(dcm - lv)/(uv - lv);
   fileName1=strcat('F:\��ҽX�ߺ�MRI����ָ�\RripleNegative\��С��22848509\dcm2png\',files(i).name);
   fileName1(end-3:end)=[];
   fileName2=strcat(fileName1,'.png'); 
   imwrite(dcmIM,fileName2);
end
