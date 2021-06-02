function [out,revertclass]=tofloat(in)
identity=@(x) x;
tosingle=@im2single;

table={'uint8',tosingle,@im2uint8
    'uint16',tosingle,@im2uint16
    'int16',tosingle,@im2int16
    'logical',tosingle,@logical
    'double',identity,identity
    'single',identity,identity};
classindex=find(strcmp(class(in),table(:,1)));
if isempty(classindex)
    error('unsupported input image class.');
end
out=table{classindex,2}(in);
revertclass=table{classindex,3};