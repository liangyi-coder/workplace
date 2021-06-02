function [Y] = normalize(X)
% 输入图片归一化到[0 1],double型
Y = zeros(size(X));
minX = min(X(:));
maxX = max(X(:));
if maxX>minX
    Y = (X-minX)./(maxX-minX);
else
    Y = zeros(size(X));
end

end