%��ȡȫ����ͼƬ�������I��
function I = readall(file_path);
% file_path =  'C:\Users\liangyi\workplace\MATLAB\BIg Homework\image\';% ͼ���ļ���·��  
img_path_list = dir(strcat(file_path,'*.dcm'));%��ȡ���ļ���������bmp��ʽ��ͼ��  
img_num = length(img_path_list);%��ȡͼ�������� 
I=cell(1,img_num);
if img_num > 0 %������������ͼ��  
        for j = 1:img_num %��һ��ȡͼ��  
            image_name = img_path_list(j).name;% ͼ����  
            image =  adjustW(im2double(dicomread(strcat(file_path,image_name))));  
            I{j}=image;
           

        end  
end  

%