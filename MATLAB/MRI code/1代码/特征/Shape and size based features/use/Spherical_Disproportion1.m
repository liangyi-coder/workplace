function Spherical_Disproportion=Spherical_Disproportion1(BW)
if size(BW,1) > 1
        %3D
        SurefaceArea = imSurface1(BW);
    else
        %2D
        SurefaceArea = imPerimeter1(BW);
    end
           
    
    Volume=sum(BW(:));
    Radius=(Volume*3/4/pi)^(1/3);
    
    Spherical_Disproportion=SurefaceArea/((4*pi)*(Radius^2));  
end