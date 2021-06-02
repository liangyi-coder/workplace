function out=glrl1(I)

 [ROIonly,levels] = prepareVolume(I,64);
[GLRLM] = getGLRLM(ROIonly,levels);
[out] = getGLRLMtextures(GLRLM);
end