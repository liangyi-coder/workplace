function Max3DDiameter=Max3DDiameter1(mask)
vectX = zeros(1,8*size(mask,3));
vectY = zeros(1,8*size(mask,3));
vectZ = zeros(1,8*size(mask,3));

for i = 1:size(mask,3)
    temp = regionprops(mask(:,:,i),'Extrema');
    try
        temp = temp.Extrema;
        temp = temp';
        vectX((i-1)*8 + 1:i*8) = temp(1,:) ;
        vectY((i-1)*8 + 1:i*8) = temp(2,:) ;
        vectZ((i-1)*8 + 1:i*8) = (i-1) ;
    catch % Will always work, except when the first slice contains all zeros
        vectX((i-1)*8 + 1:i*8) = vectX(((i-1)-1)*8 + 1:(i-1)*8);
        vectY((i-1)*8 + 1:i*8) = vectY(((i-1)-1)*8 + 1:(i-1)*8);
        vectZ((i-1)*8 + 1:i*8) = vectZ(((i-1)-1)*8 + 1:(i-1)*8);
    end
end

max = 0;
for i = 1:8*size(mask,3) - 1
    for j = i + 1:8*size(mask,3)
       dist = (vectX(i)-vectX(j))^2 + (vectY(i)-vectY(j))^2 + (vectZ(i)-vectZ(j))^2;
       if dist > max
           max = dist;
       end
    end
end

Max3DDiameter = sqrt(max);
end