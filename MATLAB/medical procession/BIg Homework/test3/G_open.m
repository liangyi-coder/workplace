function T = G_open(im)


%¿ªÔËËã
s = size(im);
h = s(1);
w = s(2);

im1 = zeros(h,w);
 for i = 1:h
     for j = 1:w
         im1(i,j) = minGray_edge(3,im,i,j);
     end
 end
 
 im2 = zeros(h,w);
 for i = 1:h
     for j = 1:w
         im2(i,j) = maxGray_edge(3,im1,i,j);
     end
 end
 
T=im2; 
 
end
     