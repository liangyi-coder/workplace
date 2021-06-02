function Sphericity=Sphericity1(BW)
if size(BW,1) > 1
        %3D
        SurefaceArea = imSurface1(BW);
    else
        %2D
        SurefaceArea = imPerimeter1(BW);
    end
           
    
    Volume=sum(BW(:));
    Sphericity=(pi^(1/3))*((6*Volume)^(2/3))/SurefaceArea;     
end