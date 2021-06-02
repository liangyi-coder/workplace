function [surf] = imSurface1(mask)
perimeter = bwperim(mask,26);%从输入图像中返回只包括对象边缘像素点的二值图像
surf = length(find(perimeter));%边缘像素点个数