clc;
clear;

im = imread('T.jpg');

sz = size(im);
h = sz(1);
w = sz(2);
ch = sz(3);
 
cch = round(h/2)+1;
cw = round(w/2)+1;
c = [cch;cw];

angle = 90/180*pi;
R = [cos(angle),-sin(angle);sin(angle),cos(angle)];

h1 = round(abs(h*cos(angle))+abs(w*sin(angle)))+1;
w1 = round(abs(h*sin(angle))+abs(w*cos(angle)))+1;


ch1 = round(h1/2)+1;
cw1 = round(w1/2)+1;
c1 = [ch1;cw1];



im1 = uint8(ones(h1,w1,ch));


for i = 1:h
    for j = 1:w
        p = [i;j];
        pp = round(R*(p-c)+c1);
        if (pp(1) >=2 && pp(1)<=h1-1 && pp(2) >= 2 && pp(2) <=w1-1)
            im1(pp(1),pp(2),:) = im(p(1),p(2),:);
            im1(pp(1)+1,pp(2),:) = im(p(1),p(2),:);
            im1(pp(1)-1,pp(2),:) = im(p(1),p(2),:);
            im1(pp(1),pp(2)+1,:) = im(p(1),p(2),:);
            im1(pp(1),pp(2)-1,:) = im(p(1),p(2),:);
        end
    end
end

figure;
imshow(im1)