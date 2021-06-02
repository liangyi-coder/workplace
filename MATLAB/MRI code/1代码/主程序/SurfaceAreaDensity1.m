function SurfaceAreaDensity=SurfaceAreaDensity1(img)
if size(img, 3) > 1
    s = imSurface1(img);
else
    s = imPerimeter1(img);
end

% total volume of image (without edges)
refVol = sum(img(:));
SurfaceAreaDensity = s / refVol;