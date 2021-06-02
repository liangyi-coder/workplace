function out=statistics1(I)
% 1	GlobalMax'
% 2	GlobalMin'
% 3	GlobalMedian'
% 4	GlobalMean'
% 5	Range'
% 6	Kurtosis'
% 7	Skewness'
% 8	GlobalStd'
% 9	LocalEntropyMax'
% 10	LocalEntropyMedian'
% 11	LocalEntropyMin'
% 12	LocalEntropyMean'
% 13	LocalEntropyStd'
% 14	LocalRangeMax'
% 15	LocalRangeMedian'
% 16	LocalRangeMin'
% 17	LocalRangeMean'
% 18	LocalRangeStd'
% 19	LocalStdMax'
% 20	LocalStdMin'
% 21	LocalStdMedian'
% 22	LocalStdMean'
% 23	LocalStdStd'
% 24	MeanAbsoluteDeviation'
% 25	MedianAbsoluteDeviation'
% 26	InterQuartileRange'
% 27	Energy'
% 28	RootMeanSquare'
% 29	Variance'
% 30	GlobalEntropy'
% 31	GlobalUniformity'
Mask=I(logical(I));
GlobalMax=max(Mask(:));
GlobalMin=min(Mask(:));
GlobalMedian=median(Mask(:));
GlobalMean=mean(Mask(:));
Range=GlobalMax-GlobalMin;
Kurtosis=kurtosis(Mask(:));
Skewness=skewness(Mask(:));
GlobalStd=std(Mask(:));
NHood=ones(3,3,3);
LocalEntropyMax=ComputeLocalEntropyFeature1(I,NHood, 'Max');
LocalEntropyMedian=ComputeLocalEntropyFeature1(I,NHood, 'Median');
LocalEntropyMin=ComputeLocalEntropyFeature1(I,NHood, 'Min');
LocalEntropyMean=ComputeLocalEntropyFeature1(I,NHood, 'Mean');
LocalEntropyStd=ComputeLocalEntropyFeature1(I,NHood, 'Std');
LocalRangeMax=ComputeLocalRangeFeature1(I,NHood, 'Max');
LocalRangeMedian=ComputeLocalRangeFeature1(I,NHood, 'Median');
LocalRangeMin=ComputeLocalRangeFeature1(I,NHood, 'Min');
LocalRangeMean=ComputeLocalRangeFeature1(I,NHood, 'Mean');
LocalRangeStd=ComputeLocalRangeFeature1(I,NHood, 'Std');
LocalStdMax=ComputeLocalStdFeature1(I,NHood, 'Max');
LocalStdMin=ComputeLocalStdFeature1(I,NHood, 'Median');
LocalStdMedian=ComputeLocalStdFeature1(I,NHood, 'Min');
LocalStdMean=ComputeLocalStdFeature1(I,NHood, 'Mean');
LocalStdStd=ComputeLocalStdFeature1(I,NHood, 'Std');
MeanAbsoluteDeviation=mad(Mask(:), 0);
MedianAbsoluteDeviation=mad(Mask(:), 1);
InterQuartileRange=iqr(Mask(:));
Energy= sum((double(Mask(:))).^2);
RootMeanSquare=sqrt(mean((double(Mask(:))).^2));
Variance=var(double(Mask(:)));
NBins=64;
[GlobalEntropy,GlobalUniformity]=Global1(I, NBins);

out=[GlobalMax,GlobalMin,GlobalMedian,GlobalMean,Range,Kurtosis,Skewness,GlobalStd,...
    LocalEntropyMax,LocalEntropyMedian,LocalEntropyMin,LocalEntropyMean,LocalEntropyStd,...
    LocalRangeMax,LocalRangeMedian,LocalRangeMin,LocalRangeMean,LocalRangeStd,...
    LocalStdMax,LocalStdMin,LocalStdMedian,LocalStdMean,LocalStdStd,...
    MeanAbsoluteDeviation,MedianAbsoluteDeviation,InterQuartileRange,...
    Energy,RootMeanSquare,Variance,GlobalEntropy,GlobalUniformity];
out=double(out);