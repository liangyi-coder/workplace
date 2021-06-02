function [TValue]=ComputeLocalRangeFeature1(I,NHood, Mode)
ImageData=I;
BWData= logical(I);

% Bin Location
%  NHood=ones(5);
LocalRangeMat=rangefilt(I,NHood);
MaskImageMat=LocalRangeMat(logical(BWData));
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