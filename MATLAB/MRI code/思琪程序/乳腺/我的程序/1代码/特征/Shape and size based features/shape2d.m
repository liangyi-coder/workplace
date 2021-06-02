function out=shape2d(I)
% 1	Volume'->Area
% 2	Roundness'
% 3	Orientation'
% 4	solidity'
% 5	ConvexHullVolume3D'->	ConvexHullArea2D
% 6	SurfaceArea'
% 7	SurfaceAreaDensity'
% 8	MeanBreadth'
% 9	Compactness1'
% 10	Compactness2'
% 11	Max3DDiameter'
% 12	SphericalDisproportion'
% 13	Sphericity'
    [bwlab,num]=bwlabel(I);
    S= regionprops(bwlab, 'Area');
    bw1= ismember(bwlab, find([S.Area] == (max([S.Area]))));



BW=logical(bw1);
STATS =  regionprops(BW,'all');
Volume=STATS.Area;
Roundness=1-STATS.Eccentricity;
Orientation=STATS.Orientation;
solidity=STATS.Solidity;
ConvexHullVolume=STATS.ConvexArea;
SurfaceArea=SurfaceArea1(BW);
SurfaceAreaDensity=SurfaceAreaDensity1(BW);
MeanBreadth=MeanBreadth1(BW);
Compactness1=Compactness11(BW);
Compactness2=Compactness21(BW);
Max3DDiameter=Max3DDiameter1(BW);
Spherical_Disproportion=Spherical_Disproportion1(BW);
Sphericity=Sphericity1(BW);
out=[Volume,Roundness,Orientation,solidity,ConvexHullVolume,SurfaceArea,SurfaceAreaDensity,...
     MeanBreadth,Compactness1,Compactness2,Max3DDiameter,Spherical_Disproportion,Sphericity];
out=double(out);