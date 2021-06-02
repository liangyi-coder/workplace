function Compactness2=Compactness21(BWMat)
if size(BWMat,1) > 1
        %3D
        SurefaceArea = imSurface1(BWMat);
    else
        %2D
        SurefaceArea = imPerimeter1(BWMat);
    end
           
    
    Volume=sum(BWMat(:));
    Compactness2=36*pi*(Volume^2)/(SurefaceArea^3);  