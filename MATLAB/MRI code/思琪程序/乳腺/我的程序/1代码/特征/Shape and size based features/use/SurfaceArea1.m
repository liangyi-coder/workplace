function Value=SurfaceArea1(BWMat)
    if size(BWMat,3) > 1
        %3D
        Value = imSurface1(BWMat);
    else
        %2D
        Value = imPerimeter1(BWMat);
    end

end


