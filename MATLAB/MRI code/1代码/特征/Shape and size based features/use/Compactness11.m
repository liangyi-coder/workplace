function Compactness1=Compactness11(BWMat)%compactness 紧致性特征

if size(BWMat,1) > 1%返回矩阵行数
        %3D表面积
        SurefaceArea = imSurface1(BWMat);
    else
        %2D周长
        SurefaceArea = imPerimeter1(BWMat);
    end
           
    
    Volume=sum(BWMat(:));%肿瘤区域内的像素数
    
     Compactness1=Volume/(sqrt(pi)*(SurefaceArea^(2/3)));    