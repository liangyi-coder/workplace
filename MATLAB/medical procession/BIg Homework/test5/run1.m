clc;clear;
matrix = zeros(50,2);
z = 1;
%读取image和label中的数据
I_1 = readall('C:\Users\liangyi\workplace\MATLAB\BIg Homework\test5\image\');
I_2 = readall('C:\Users\liangyi\workplace\MATLAB\BIg Homework\test5\label\');



 for i=1:50
    src =I_1{i};
    srrc = I_2{i};
    
    %image中的图像做滤波变化
    src = histeq(twoEdgeF(adjustW(src)));
    src=im2uint8(src);
    figure;subplot(131),imshow(src,[]),title('src image');

%---------------------------%
%       parameter
%---------------------------%
    [m,n]=size(src);

    dst = src; 
%---------------------------%
%       output
%---------------------------%


    pic = zeros(m,n);
    if i>=1 && i<=21
        f = imcrop(dst,[95,63,125,164]);
    end
    if i>=22 && i<=31
        f = imcrop(dst,[43,50,150,150]);
    end
    if i>=32 && i<=40
        f = imcrop(dst,[10,62,100,100]);
    end
    if i>=41 && i<=50
        f = imcrop(dst,[97,107,112,112]);
    end
    subplot(132),imshow(f,[]),title('roi');

    Img = double(f);

    [row,col] = size(Img);
    phi = ones(row,col);
    phi(10:row-10,10:col-10) = -1;
    u = - phi;

% hold off;

    sigma = 1;
    G = fspecial('gaussian', 5, sigma);

    delt = 1;
    Iter = 80;
    mu = 25;%this parameter needs to be tuned according to the images

    for n = 1:Iter
        [ux, uy] = gradient(u);
   
        c1 = sum(sum(Img.*(u<0)))/(sum(sum(u<0)));% we use the standard Heaviside function which yields similar results to regularized one.
        c2 = sum(sum(Img.*(u>=0)))/(sum(sum(u>=0)));
    
        spf = Img - (c1 + c2)/2;
        spf = spf/(max(abs(spf(:))));
    
        u = u + delt*(mu*spf.*sqrt(ux.^2 + uy.^2));
        u = (u >= 0) - ( u< 0);% the selective step.
        u = conv2(u, G, 'same');
    end
    u =round(u);
    for qq = 1:row
        for pp = 1:col
            if u(qq,pp) ~=1
                u(qq,pp) = 0;
            end
        end
    end
    g = u;


    if i>=1 && i<=21
        for k = 63:227
            for l = 95:220
                pic(k,l) = g((k-62),(l-94));
            end
        end
    end

    if i>=22 && i<=31
        for k = 50:199
            for l = 43:192
                pic(k,l) = g((k-49),(l-42));
            end
        end
    end

    if i>=32 && i<=40
        for k = 62:161
            for l = 10:109
                pic(k,l) = g((k-61),(l-9));
            end
        end
    end

    if i>=41 && i<=50
        for k = 107:218
            for l = 97:208
                pic(k,l) = g((k-106),(l-96));
            end
        end
    end
    pic = logical(pic);
    imLabel = bwlabel(pic);
    stats = regionprops(imLabel,'Area');      
    area = cat(1,stats.Area);  
    index = find(area == max(area));        
    g= ismember(imLabel,index);  

    B = strel('rectangle',[5 5]);
    a1 = f;
    a1 = imdilate(a1,B);
    a1 = imdilate(a1,B);
    a1 = imdilate(a1,B);
    g = imfill(a1,'holes');
    a2 = g;
    a2 = imerode(a2,B);
    a2 = imerode(a2,B);
    a2 = imerode(a2,B);
    g = imfill(a2,'holes');
    mLabel = bwlabel(g);
    stats = regionprops(imLabel,'Area');    
    area = cat(1,stats.Area);  
    index = find(area == max(area));        
    g= ismember(imLabel,index);  
    subplot(133),imshow(g,[]),title('region');
    butong = 0;
    [m,n]=size(src);
    matrix(z,1) = Dice_Ratio(g, srrc);
    matrix(z,2) = Jaccard_Index(g, srrc);
    z = z+1;
end

