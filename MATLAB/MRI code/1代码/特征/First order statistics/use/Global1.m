function [GlobalEntropy,GlobalUniformity]=Global1(I, NBins)

[p,vox_val_hist]=histogram3d(I,NBins);
GlobalEntropy= -sum(p.*log2(p));
GlobalUniformity= sum(p.^2);

