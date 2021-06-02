%%
im_o = adjustW(dicomread('1.dcm'));
tef = twoEdgeF(im_o);
tef_h = histeq(tef);
imshow(tef_h)
%%
T = T_hat(tef_h);
imshow(T);
%%
for i = 1:10
    im_t = G_open(tef_h);
end
imshow(tef_h)
%%
im = y_est;
[h,w] = size(im);
im2 = zeros(h,w);
for i = 1:h
    for j = 1:w
        if im(i,j) >=0.3 && im(i,j)<=0.4
            im2(i,j) = 1;
        end
    end
end
%%
a = zeros(1,50);
for i = 1:50
    image = I_1{i};
    label = I_2{i};
    [h1,w1] = size(image);
    [h2,w2] = size(label);
    if h1==h2 && w1==w2
        a(i)=1;
    end
end
        