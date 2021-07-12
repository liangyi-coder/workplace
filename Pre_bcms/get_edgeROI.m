
close all; clc; clear ;
%% 读取全部文件名
fileFolder=fullfile('..\sun_Image\');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
filenamesize = size(fileNames);

fileFolder1=fullfile('..\sun_ROI\');
dirOutput1=dir(fullfile(fileFolder1,'*'));
fileNames1={dirOutput1.name}';
filenamesize1 = size(fileNames1);

%% 批量处理
N = 72;          %N为特征个数
matrix_jubu_5 = zeros(filenamesize(1,1)-2,N);%创建矩阵
% matrix1 = load('matrix_train.mat');
% matrix = matrix1.matrix;
for i = 3:filenamesize

    realfilename = fileNames(i);
    fileName = strcat('..\sun_Image\',realfilename);
    fileName = fileName{1,1};
    
    realfilename1 = fileNames1(i);
    fileName1 = strcat('..\sun_ROI\',realfilename1);
    fileName1 = fileName1{1,1};
    
    I = imread(fileName);
    ROI = imread(fileName1);  
    ROI = im2uint8(ROI)/255;   
%     Img = Grayconversion(I);             %将原图转成灰度图像
    Img = I;
    Img = rgb2gray(Img);
    Img = samesize(Img,ROI);    %使ROI和Img 的size一样大
    [m,n] = size(ROI);          %获取大小
    % ROI = im2uint8(ROI)/255;
    % figure,imshow(I);
%     figure,imshow(ROI);
    boundings = regionprops(ROI,'BoundingBox');
    xlxz = boundings.BoundingBox(1);                              %获取最小外接矩形左边界
    xrxz = boundings.BoundingBox(1)+boundings.BoundingBox(3);       %获取最小外接矩形右边界
    yhxz = boundings.BoundingBox(2);                              %获取最小外接矩形上边界
    ylxz = boundings.BoundingBox(2)+boundings.BoundingBox(4);       %获取最小外接矩形下边界
    xlxz = ceil(xlxz);          %朝正无穷大方向取整
    xrxz = floor(xrxz);
    yhxz = ceil(yhxz);          %朝正无穷大方向取整
    ylxz = floor(ylxz);
    newROI = ROI(yhxz:ylxz,xlxz:xrxz);
%     figure;imshow(newROI*255);
    In = Img.*ROI;              %获取肿瘤内部灰度图像
    figure;imshow(In);
    newIn = In(yhxz:ylxz,xlxz:xrxz);
%     figure;imshow(newIn);

    Iedge = edge(ROI,'canny');  %提出肿瘤边缘Iedge
%     figure,imshow(Iedge);
    Iedge = im2uint8(Iedge)/255;
    se = strel('disk',5);      % strel('disk', R, N)创建一个指定半径R的平面圆盘形的结构元素，N省略时为4
    Iegenew = imdilate(Iedge,se);
    Ibydai = Iegenew.*Img;      %得到边缘带灰度图像
    figure,imshow(Ibydai);
    I1= (Iedge*255)+Ibydai;
    % figure,imshow(I1);
    ROInew = imdilate(ROI,se);
%     figure,imshow(ROInew*255);
    ROI1=ROInew-ROI;
%     figure,imshow(ROI1);
%     ROI1 = im2uint8(ROI1)/255;
    Ibydai1 = ROI1.*Img;
%     figure,imshow(Ibydai1);
    I3= (Iedge*255)+Ibydai1;
%     figure,imshow(I3);
    byname = strcat('C:\Users\Yu\Desktop\sunhang\json\mask_zhongliu\',dirOutput(i).name);
    byname(end-3:end)=[];
    byname1=strcat(byname,'.png'); 
    imwrite(In,byname1);
end