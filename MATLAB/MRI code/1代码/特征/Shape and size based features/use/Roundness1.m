function [Roundness] =Roundness1(mask)
Value=[];

for i=1:size(mask, 3)
    CurrentSlice=mask(:, :, i);
    TempIndex=find(CurrentSlice);
    
    if ~isempty(TempIndex)
        Stas=regionprops(CurrentSlice, 'Eccentricity');
        CurrentValue=Stas.Eccentricity;  
        Value=[Value; CurrentValue];
    end    
end
 Value=mean(Value);   
Roundness=1-Value







% % INITIALIZATION OF ECCENTRICITY COMPUTATION
% perimeter = bwperim(mask,26);%从输入图像中返回只包括对象边缘像素点的二值图像
% nPoints = length(find(perimeter));%边缘像素点个数
% X = zeros(nPoints,1); Y = zeros(nPoints,1); Z = zeros(nPoints,1);%存储边缘像素点坐标
% count = 1;
% for i = 1:size(perimeter,3)
%     [row,col] = find(perimeter(:,:,i));
%     p = length(row);
%     if p > 0
%         X(count:count+p-1,1) = col(1:end);
%         Y(count:count+p-1,1) = row(1:end);
%         Z(count:count+p-1,1) = i;
%         count = count + p;
%     end
% end
% 
% 
% % LI'S ELLIPSOID FITTING ALGORITHM
% dx = X(:); dy = Y(:); dz = Z(:);
% n = size(dx,1);
% D = [dx.*dx, dy.*dy,  dz.*dz, 2.*dy.*dz, 2.*dx.*dz, 2.*dx.*dy, ...
%         2.*dx, 2.*dy, 2.*dz, ones(n,1)]';
% S = D*D';
% 
% % Create constraint matrix C:
% C(6,6)=0; C(1,1)=-1; C(2,2)=-1; C(3,3)=-1; C(4,4)=-4; C(5,5)=-4; C(6,6)=-4;
% C(1,2)=1; C(2,1)=1; C(1,3)=1; C(3,1)=1; C(2,3)=1; C(3,2)=1;
% 
% % Solve generalized eigensystem
% S11 = S(1:6, 1:6); S12 = S(1:6, 7:10); S22 = S(7:10,7:10);
% A = S11-S12*pinv(S22)*S12'; CA = inv(C)*A;
% [gevec, geval] = eig(CA);
% 
% % Find the largest eigenvalue(the only positive eigenvalue)
% In = 1;
% maxVal = geval(1,1);
% for i = 2:6
%    if (geval(i,i) > maxVal)
%        maxVal = geval(i,i);
%        In = i;
%    end;
% end;
% 
% % Find the fitting
% v1 = gevec(:, In); 
% v2 = -pinv(S22)*S12'*v1;
% v = [v1; v2];
% 
% % Algebraic from of the ellipsoid
% A = [ v(1) v(6) v(5) v(7); ...
%   v(6) v(2) v(4) v(8); ...
%   v(5) v(4) v(3) v(9); ...
%   v(7) v(8) v(9) -1 ];
% 
% % Center of the ellipsoid
% center = -A( 1:3, 1:3 ) \ [ v(7); v(8); v(9) ];
% 
% % Corresponding translation matrix
% T = eye( 4 );
% T(4, 1:3 ) = center';
% 
% % Translating to center
% R = T * A * T';
% 
% % Solving eigenproblem
% [ evecs evals ] = eig( R( 1:3, 1:3 ) / -R( 4, 4 ) );
% radii = sqrt( 1 ./ diag( evals ) );
% 
% 
% % ECCENTRICITY COMPUTATION
% % - eccentricity: Metric given by sqrt[1 - a*b/c^2] where c is the longest 
% %                 semi-principal axes of the ellipsoid, and a and b are the 
% %                 second and third longest semi-principal axes of the 
% %                 ellipsoid.
% eccentricity = sqrt(1 - (radii(2)*radii(3)/radii(1)^2));
% Roundness=1-eccentricity;
% end