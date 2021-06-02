%´ú¼Ûº¯Êý

[x,y] = meshgrid(-20:0.5:20,-20:0.5:20);
z = x.^2+y.^2;
mesh(x,y,z);xlabel('x');ylabel('y');zlabel('z');