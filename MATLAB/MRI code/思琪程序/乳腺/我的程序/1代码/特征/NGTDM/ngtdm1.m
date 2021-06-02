function out=ngtdm1(I)
 [ROIonly,levels] = prepareVolume(I,64);
[NGTDM,countValid] = getNGTDM(ROIonly,levels);
[out] = getNGTDMtextures(NGTDM,countValid);
end