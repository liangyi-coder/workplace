function [Igrow] = regionGrowing(cIM, initPos, thresVal)
% REGIONGROWING Region growing algorithm for 2D/3D grayscale images
% Inputs:
% cIM: 2D/3D grayscale matrix{current image}
% initPos: Coordinates for initial seed position   
% thresVal: Absolute threshold level to be included    

if ~exist('initPos', 'var') || isempty(initPos)
    n=round(size(cIM,3)/2);
    imshow(cIM(:,:,n),[]);
    % graphical user input for the initial position
    p = ginput(1);   
    % get the pixel position concerning to the current axes coordinates
    initPos(1) = round( p(2));
    initPos(2) = round(p(1));
    initPos(3) =n;
end
maxDist = Inf;%不限制生长范围
[nRow, nCol, nSli] = size(cIM);
% initial pixel value
regVal = double(cIM(initPos(1), initPos(2), initPos(3)));
% text output with initial parameters
disp(['RegionGrowing Opening: Initial position (' num2str(initPos(1))...
      '|' num2str(initPos(2)) '|' num2str(initPos(3)) ') with '...
      num2str(regVal) ' as initial pixel value!'])
% preallocate array
J = false(nRow, nCol, nSli);
% add the initial pixel to the queue
queue = [initPos(1), initPos(2), initPos(3)];
%%% START OF REGION GROWING ALGORITHM
while size(queue, 1)
  % the first queue position determines the new values
  xv = queue(1,1);
  yv = queue(1,2);
  zv = queue(1,3);
  % .. and delete the first queue position
  queue(1,:) = [];
  % check the neighbors for the current position
  for i = -1:1
    for j = -1:1
      for k = -1:1
            
        if xv+i > 0  &&  xv+i <= nRow &&...          % within the x-bounds?
           yv+j > 0  &&  yv+j <= nCol &&...          % within the y-bounds?          
           zv+k > 0  &&  zv+k <= nSli &&...          % within the z-bounds?
           any([i, j, k])       &&...      % i/j/k of (0/0/0) is redundant!
           ~J(xv+i, yv+j, zv+k) &&...          % pixelposition already set?
           sqrt( (xv+i-initPos(1))^2 +...
                 (yv+j-initPos(2))^2 +...
                 (zv+k-initPos(3))^2 ) < maxDist &&...   % within distance?
           cIM(xv+i, yv+j, zv+k) <= (regVal + thresVal) &&...% within range
           cIM(xv+i, yv+j, zv+k) >= (regVal - thresVal) % of the threshold?

           % current pixel is true, if all properties are fullfilled
           J(xv+i, yv+j, zv+k) = true; 

           % add the current pixel to the computation queue (recursive)
           queue(end+1,:) = [xv+i, yv+j, zv+k];
           %生长阈值更新为已生长区的均值
           regVal = mean(mean(cIM(J > 0)));
        end        
      end
    end  
  end
end
%%% END OF REGION GROWING ALGORITH
% loop through each slice, fill holes and extract the polygon vertices
P = [];
for cSli = 1:nSli
    if ~any(J(:,:,cSli))
        continue
    end
        % fill the holes inside the mask
        J(:,:,cSli) =bwmorph(J(:,:,cSli), 'dilate');
        J(:,:,cSli) =imfill(J(:,:,cSli), 'holes');   
end 
Igrow=immultiply(cIM,J);

 

