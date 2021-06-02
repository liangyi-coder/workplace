function [TValue]=ComputeLocalStdFeature1(I,NHood,Mode)
ImageData=I;
BWData= logical(I);

%Method 1
InputRange=[min(I(:)),max(I(:))];
FinalRange=[0,255];
ImageData=double(ImageData);
ImageData=(ImageData-InputRange(1))*(FinalRange(2)-FinalRange(1))/(InputRange(2)-InputRange(1))+FinalRange(1);
ImageData=uint8(ImageData);
 LocalStdMat=stdfilt(ImageData, NHood);
MaskImageMat=LocalStdMat(logical(BWData));
MaskImageMat=MaskImageMat(:);
switch Mode
    case 'Max'
        TValue= max(double(MaskImageMat));
    case 'Median'
        TValue= median(double(MaskImageMat));
    case 'Min'
        TValue= min(double(MaskImageMat));
    case 'Mean'
        TValue= mean(double(MaskImageMat));
    case 'Std'
        TValue= std(double(MaskImageMat));        
end
end