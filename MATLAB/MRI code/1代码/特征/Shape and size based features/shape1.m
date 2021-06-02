function out=shape1(I)
% 1	Volume'
% 2	Roundness'
% 3	Orientation'
% 4	Convex'
% 5	ConvexHullVolume3D'
% 6	SurfaceArea'
% 7	SurfaceAreaDensity'
% 8	MeanBreadth'
% 9	Compactness1'
% 10	Compactness2'
% 11	Max3DDiameter'
% 12	SphericalDisproportion'
% 13	Sphericity'

BW=logical(I);
Volume=sum(BW(:));
Roundness=Roundness1(BW);
Orientation=Orientation1(BW);
% solidity=Solidity1(BW);
ConvexHullVolume=ConvexHullVolume1(BW);
solidity=ConvexHullVolume/Volume;
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