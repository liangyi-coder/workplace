function out=glcm1(I)
[ROIonly,levels] = prepareVolume(I,64);
[GLCM] = getGLCM(ROIonly,levels);
[out] = GLCM_Features1(GLCM);
end


