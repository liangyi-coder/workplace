function [surf] = imSurface1(mask)
perimeter = bwperim(mask,26);%������ͼ���з���ֻ���������Ե���ص�Ķ�ֵͼ��
surf = length(find(perimeter));%��Ե���ص����