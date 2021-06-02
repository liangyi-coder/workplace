function out=hist1(I)
% (1) Mean
% (2) Variance
% (3) Skewness
% (4) Kurtosis
% (5) Energy
% (6) Entropy
% (7)Uniformity

%  p=1;
%  load(['D:\乳腺\我的程序\1数据\MR\DWI\输入腺体\4组1\1\in_mr',num2str(p)]);
% I=in;
num_img_values=64;
[vox_val_probs,vox_val_hist]=histogram3d(I,num_img_values);
out = histfea(vox_val_probs,num_img_values);


