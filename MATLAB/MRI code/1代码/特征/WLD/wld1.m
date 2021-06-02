function out=wld1(I)
[ DE,ORT ] = WLD( I,logical(I) );%用于计算WLD得到
 f_DE=wldfeatures( DE );
f_ORT=wldfeatures( DE );
out=[f_DE,f_ORT];



end