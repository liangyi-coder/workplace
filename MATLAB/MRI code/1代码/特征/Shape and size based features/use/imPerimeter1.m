function [perim ] = imPerimeter1(mask)
perimeter = bwperim(mask,8);%从输入图像中返回只包括对象边缘像素点的二值图像
perim = length(find(perimeter));


% % in case of binary image, compute only one label
% labels = 1;
% 
% % default number of directions
% nDirs = 4;
% 
% % default image resolution
% delta = [1 1];
% 
% % parse parameter name-value pairs
% while ~isempty(varargin)
%     var = varargin{1};
%     
%     if isnumeric(var)        
%         % option is either number of directions or resolution
%         if isscalar(var)
%             nDirs = var;
%         else
%             delta = var;
%         end
%         varargin(1) = [];
%         
%     elseif ischar(var)
%         if length(varargin) < 2
%             error('Parameter name must be followed by parameter value');
%         end
%     
%         if strcmpi(var, 'ndirs')
%             nDirs = varargin{2};
%         elseif strcmpi(var, 'resolution')
%             delta = varargin{2};
%         else
%             error(['Unknown parameter name: ' var]);
%         end
%         
%         varargin(1:2) = [];
%     end
% end
% 
% 
% %% Initialisations 
% 
% % distances between a pixel and its neighbours.
% % (d1 is dx, d2 is dy)
% d1  = delta(1);
% d2  = delta(2);
% d12 = hypot(d1, d2);
% 
% % area of a pixel (used for computing line densities)
% vol = d1 * d2;
% 
% % size of image
% dim = size(img);
% D1  = dim(1);
% D2  = dim(2);
% 
% 
% %% Processing for 2 or 4 main directions
% 
% % compute number of pixels, equal to the total number of vertices in graph
% % reconstructions 
% nv = sum(img(:));
% 
% % compute number of connected components along orthogonal lines
% % (Use Graph-based formula: chi = nVertices - nEdges)
% n1 = nv - sum(sum(img(:, 1:D2-1) & img(:, 2:D2)));
% n2 = nv - sum(sum(img(1:D1-1, :) & img(2:D1, :)));
% 
% % Compute perimeter using 2 directions
% % equivalent to:
% % perim = mean([n1/(d1/a) n2/(d2/a)])*pi/2;
% % with a = d1*d2 being the area of the unit tile
% if nDirs == 2
%     perim = pi * mean([n1*d2 n2*d1]);
%     return;
% end
% 
% 
% %% Processing specific to 4 directions
% 
% % Number of connected components along diagonal lines
% n3 = nv - sum(sum(img(1:D1-1, 1:D2-1) & img(2:D1,   2:D2)));
% n4 = nv - sum(sum(img(1:D1-1, 2:D2  ) & img(2:D1, 1:D2-1)));
% 
% % compute direction weights (necessary for anisotropic case)
% if any(delta ~= 1);
%     c = computeDirectionWeights2d4(delta)';
% else
%     c = [1 1 1 1] / 4;
% end
% 
% % compute weighted average over directions
% perim = pi * sum( [n1/d1 n2/d2 n3/d12 n4/d12] * vol .* c );
