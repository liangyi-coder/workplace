function ConvexHullVolume=ConvexHullVolume1(BWMat)
TempIndex=find(BWMat);
[RowIndex, ColIndex, PageIndex]=ind2sub(size(BWMat), TempIndex);%不为0像素点的坐标

try 
    [ConvexHullRep, ConvexVolume] = convhull(ColIndex, RowIndex, PageIndex);
catch
    ConvexVolume=0; ConvexHullRep = [0,0,0];
end
ConvexHullVolume=ConvexVolume;
end