function Compactness1=Compactness11(BWMat)%compactness ����������

if size(BWMat,1) > 1%���ؾ�������
        %3D�����
        SurefaceArea = imSurface1(BWMat);
    else
        %2D�ܳ�
        SurefaceArea = imPerimeter1(BWMat);
    end
           
    
    Volume=sum(BWMat(:));%���������ڵ�������
    
     Compactness1=Volume/(sqrt(pi)*(SurefaceArea^(2/3)));    