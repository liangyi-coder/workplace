%读取全部的图片，存放在I中
function I = readall(file_path);
% file_path =  'C:\Users\liangyi\workplace\MATLAB\BIg Homework\image\';% 图像文件夹路径  
img_path_list = dir(strcat(file_path,'*.dcm'));%获取该文件夹中所有bmp格式的图像  
img_num = length(img_path_list);%获取图像总数量 
I=cell(1,img_num);
if img_num > 0 %有满足条件的图像  
        for j = 1:img_num %逐一读取图像  
            image_name = img_path_list(j).name;% 图像名  
            image =  adjustW(im2double(dicomread(strcat(file_path,image_name))));  
            I{j}=image;
           

        end  
end  

%