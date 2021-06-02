function Value=Orientation1(BWMat);
Value=[];

for i=1:size(BWMat, 3)
    CurrentSlice=BWMat(:, :, i);
    TempIndex=find(CurrentSlice);
    
    if ~isempty(TempIndex)
        Stas=regionprops(CurrentSlice, 'Orientation');
        CurrentValue=Stas.Orientation;
        
        Value=[Value; CurrentValue];
    end    
end

if ~isempty(Value)
    Value=mean(Value);    
end
end
