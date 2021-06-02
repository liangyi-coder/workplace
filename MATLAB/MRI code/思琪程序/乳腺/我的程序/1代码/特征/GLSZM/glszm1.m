function out=nglsm1(I)
 [ROIonly,levels] = prepareVolume(I,64);
[GLSZM] = getGLSZM(ROIonly,levels);
[out] = getGLSZMtextures(GLSZM);
end