 clear all
close all
clc

for i = 1:5:50
    name1 = dicomread(strcat(num2str(i),'.dcm'));
    name2 = dicomread(strcat(num2str(i+1),'.dcm'));
    name3 = dicomread(strcat(num2str(i+2),'.dcm'));
    name4 = dicomread(strcat(num2str(i+3),'.dcm'));
    name5 = dicomread(strcat(num2str(i+4),'.dcm'));

    figure()
    subplot(151);imshow(name1,[])
    subplot(152);imshow(name2,[])
    subplot(153);imshow(name3,[])
    subplot(154);imshow(name4,[])
    subplot(155);imshow(name5,[])

end