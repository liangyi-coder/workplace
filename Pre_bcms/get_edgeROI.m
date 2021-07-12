
close all; clc; clear ;
%% ��ȡȫ���ļ���
fileFolder=fullfile('..\sun_Image\');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
filenamesize = size(fileNames);

fileFolder1=fullfile('..\sun_ROI\');
dirOutput1=dir(fullfile(fileFolder1,'*'));
fileNames1={dirOutput1.name}';
filenamesize1 = size(fileNames1);

%% ��������
N = 72;          %NΪ��������
matrix_jubu_5 = zeros(filenamesize(1,1)-2,N);%��������
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
%     Img = Grayconversion(I);             %��ԭͼת�ɻҶ�ͼ��
    Img = I;
    Img = rgb2gray(Img);
    Img = samesize(Img,ROI);    %ʹROI��Img ��sizeһ����
    [m,n] = size(ROI);          %��ȡ��С
    % ROI = im2uint8(ROI)/255;
    % figure,imshow(I);
%     figure,imshow(ROI);
    boundings = regionprops(ROI,'BoundingBox');
    xlxz = boundings.BoundingBox(1);                              %��ȡ��С��Ӿ�����߽�
    xrxz = boundings.BoundingBox(1)+boundings.BoundingBox(3);       %��ȡ��С��Ӿ����ұ߽�
    yhxz = boundings.BoundingBox(2);                              %��ȡ��С��Ӿ����ϱ߽�
    ylxz = boundings.BoundingBox(2)+boundings.BoundingBox(4);       %��ȡ��С��Ӿ����±߽�
    xlxz = ceil(xlxz);          %�����������ȡ��
    xrxz = floor(xrxz);
    yhxz = ceil(yhxz);          %�����������ȡ��
    ylxz = floor(ylxz);
    newROI = ROI(yhxz:ylxz,xlxz:xrxz);
%     figure;imshow(newROI*255);
    In = Img.*ROI;              %��ȡ�����ڲ��Ҷ�ͼ��
    figure;imshow(In);
    newIn = In(yhxz:ylxz,xlxz:xrxz);
%     figure;imshow(newIn);

    Iedge = edge(ROI,'canny');  %���������ԵIedge
%     figure,imshow(Iedge);
    Iedge = im2uint8(Iedge)/255;
    se = strel('disk',5);      % strel('disk', R, N)����һ��ָ���뾶R��ƽ��Բ���εĽṹԪ�أ�Nʡ��ʱΪ4
    Iegenew = imdilate(Iedge,se);
    Ibydai = Iegenew.*Img;      %�õ���Ե���Ҷ�ͼ��
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