function breadth=MeanBreadth1(img)
if size(img,3)>1
    breadth=(sum(img(:))/pi).^(1/3)*3/4*2;
else
    breadth=(sum(img(:))/pi).^(1/3)*2;
end

% labels = 1;
% % default number of directions
% nDirs = 3;
% % default image resolution
% delta = [1 1 1];
% 
% %% Initialisations
% 
% % distances between a pixel and its neighbours.
% d1  = delta(1);
% d2  = delta(2);
% d3  = delta(3);
% vol = d1 * d2 * d3;
% 
% 
% %% Main processing for 3 directions
% 
% % number of voxels
% nv = sum(img(:));
% 
% % number of connected components along the 3 main directions
% ne1 = sum(sum(sum(img(1:end-1,:,:) & img(2:end,:,:))));
% ne2 = sum(sum(sum(img(:,1:end-1,:) & img(:,2:end,:))));
% ne3 = sum(sum(sum(img(:,:,1:end-1) & img(:,:,2:end))));
% 
% % number of square faces on plane with normal directions 1 to 3
% nf1 = sum(sum(sum(...
%     img(:,1:end-1,1:end-1) & img(:,2:end,1:end-1) & ...
%     img(:,1:end-1,2:end)   & img(:,2:end,2:end)     )));
% nf2 = sum(sum(sum(...
%     img(1:end-1,:,1:end-1) & img(2:end,:,1:end-1) & ...
%     img(1:end-1,:,2:end)   & img(2:end,:,2:end)     )));
% nf3 = sum(sum(sum(...
%     img(1:end-1,1:end-1,:) & img(2:end,1:end-1,:) & ...
%     img(1:end-1,2:end,:)   & img(2:end,2:end,:)     )));
% 
% % mean breadth in 3 main directions
% b1 = nv - (ne2 + ne3) + nf1;
% b2 = nv - (ne1 + ne3) + nf2;
% b3 = nv - (ne1 + ne2) + nf3;
% 
% % inverse of planar density (in m = m^3/m^2) in each direction
% a1 = vol / (d2 * d3);
% a2 = vol / (d1 * d3);
% a3 = vol / (d1 * d2);
% 
% if nDirs == 3
%     breadth = (b1 * a1 + b2 * a2 + b3 * a3) / 3;
%     return;
% end
% 
% 
% % number of connected components along the 6 planar diagonal 
% ne4 = sum(sum(sum(img(1:end-1,1:end-1,:) & img(2:end,2:end,:))));
% ne5 = sum(sum(sum(img(1:end-1,2:end,:) & img(2:end,1:end-1,:))));
% ne6 = sum(sum(sum(img(1:end-1,:,1:end-1) & img(2:end,:,2:end))));
% ne7 = sum(sum(sum(img(1:end-1,:,2:end) & img(2:end,:,1:end-1))));
% ne8 = sum(sum(sum(img(:,1:end-1,1:end-1,:) & img(:,2:end,2:end))));
% ne9 = sum(sum(sum(img(:,1:end-1,2:end,:) & img(:,2:end,1:end-1))));
% 
% % % number of connected components along the 4 inner diagonals
% % ne10 = sum(sum(sum(img(1:end-1,1:end-1,1:end-1) & img(2:end,2:end,2:end))));
% % ne11 = sum(sum(sum(img(2:end,1:end-1,1:end-1) & img(1:end-1,2:end,2:end))));
% % ne12 = sum(sum(sum(img(1:end-1,2:end,1:end-1) & img(2:end,1:end-1,2:end))));
% % ne13 = sum(sum(sum(img(2:end,2:end,1:end-1) & img(1:end-1,1:end-1,2:end))));
% % 
% 
% % number of square faces on plane with normal directions 4 to 9
% nf4 = sum(sum(sum(...
%     img(2:end,1:end-1,1:end-1) & img(1:end-1,2:end,1:end-1) & ...
%     img(2:end,1:end-1,2:end)   & img(1:end-1,2:end,2:end)    )));
% nf5 = sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(2:end,2:end,1:end-1) & ...
%     img(1:end-1,1:end-1,2:end)   & img(2:end,2:end,2:end)    )));
% 
% nf6 = sum(sum(sum(...
%     img(2:end,1:end-1,1:end-1) & img(2:end,2:end,1:end-1) & ...
%     img(1:end-1,1:end-1,2:end) & img(1:end-1,2:end,2:end)  )));
% nf7 = sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(1:end-1,2:end,1:end-1) & ...
%     img(2:end,1:end-1,2:end)     & img(2:end,2:end,2:end)  )));
% 
% nf8 = sum(sum(sum(...
%     img(1:end-1,2:end,1:end-1) & img(2:end,2:end,1:end-1) & ...
%     img(1:end-1,1:end-1,2:end) & img(2:end,1:end-1,2:end)    )));
% nf9 = sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(2:end,1:end-1,1:end-1) & ...
%     img(1:end-1,2:end,2:end) & img(2:end,2:end,2:end)    )));
% 
% b4 = nv - (ne5 + ne3) + nf4;
% b5 = nv - (ne4 + ne3) + nf5;
% b6 = nv - (ne7 + ne2) + nf6;
% b7 = nv - (ne6 + ne2) + nf7;
% b8 = nv - (ne9 + ne1) + nf8;
% b9 = nv - (ne8 + ne1) + nf9;
% 
% if nDirs == 9
%     error('not yet implemented');
% end
% 
% 
% % number of triangular faces on plane with normal directions 10 to 13
% nf10 = sum(sum(sum(...
%     img(2:end,1:end-1,1:end-1) & img(1:end-1,2:end,1:end-1) & ...
%     img(1:end-1,1:end-1,2:end)    ))) ...
%     + sum(sum(sum(...
%     img(2:end,2:end,1:end-1) & img(1:end-1,2:end,2:end) & ...
%     img(2:end,1:end-1,2:end)    ))) ;
% 
% nf11 = sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(2:end,2:end,1:end-1) & ...
%     img(2:end,1:end-1,2:end)    ))) ...
%     + sum(sum(sum(...
%     img(1:end-1,2:end,1:end-1) & img(1:end-1,1:end-1,2:end) & ...
%     img(2:end,2:end,2:end)    ))) ;
% 
% nf12 = sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(2:end,2:end,1:end-1) & ...
%     img(1:end-1,2:end,2:end)    ))) ...
%     + sum(sum(sum(...
%     img(2:end,1:end-1,1:end-1) & img(1:end-1,1:end-1,2:end) & ...
%     img(2:end,2:end,2:end)    ))) ;
% 
% nf13 = sum(sum(sum(...
%     img(2:end,1:end-1,1:end-1) & img(1:end-1,2:end,1:end-1) & ...
%     img(2:end,2:end,2:end)  )))   ...
%     + sum(sum(sum(...
%     img(1:end-1,1:end-1,1:end-1) & img(2:end,1:end-1,2:end) & ...
%     img(1:end-1,2:end,2:end)    ))) ;
% 
% % length of diagonals
% d12 = hypot(d1, d2);
% d13 = hypot(d1, d3);
% d23 = hypot(d2, d3);
% 
% % inverse of planar density (in m = m^3/m^2) in directions 4 to 13
% a4 = vol / (d3 * d12);
% a6 = vol / (d2 * d13);
% a8 = vol / (d1 * d23);
% 
% % compute area of diagonal triangle via Heron's formula
% s  = (d12 + d13 + d23) / 2;
% a10 = vol / (2 * sqrt( s * (s-d12) * (s-d13) * (s-d23) ));
% 
% 
% b10 = nv - (ne5 + ne7 + ne9) + nf10;
% b11 = nv - (ne4 + ne6 + ne9) + nf11;
% b12 = nv - (ne4 + ne7 + ne8) + nf12;
% b13 = nv - (ne5 + ne6 + ne8) + nf13;
% 
% if nDirs~=13
%     error('Unknown number of directions');
% end
% 
% c = sphericalCapsAreaC26(delta([2 1 3]))*2;
% 
% % weighted average over directions
% breadth = ...
%     (b1*c(1)*a1 + b2*c(2)*a2 + b3*c(3)*a3) + ...
%     ((b4+b5)*c(4)*a4 + (b6+b7)*c(6)*a6 + (b8+b9)*c(8)*a8) + ...
%     ((b10 + b11 + b12 + b13)*c(10)*a10) ;
% end
