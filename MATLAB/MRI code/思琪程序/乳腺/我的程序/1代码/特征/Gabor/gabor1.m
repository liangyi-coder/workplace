function[f] = gabor1(img)
%[幅：角1尺1，角1尺2···相位：角1尺1，角1尺2]
k1=1;
f_An=[];
f_PH=[];

theta = [0 pi/8 pi/4 3*pi/8 pi/2 5*pi/8 3*pi/4 7*pi/8];
% lambda = [2 4 6 8 10 12];
lambda = [1:5];%五个尺度
phi = 0;
gamma = 1;
bw = 0.5;

    % 计算每个滤波器
    % figure;
    f=[];
%     for i = 1:length(lambda)
        for j = 1:length(theta)
            for i = 1:length(lambda)
            gaborFilter=gaborKernel2d(lambda(i), theta(j), phi, gamma, bw);
       EO{i,j}=imfilter(img,real(gaborFilter));
          An = abs(EO{i,j});                        % Amplitude of filter response.
            PH=angle(EO{i,j}); 

    
           f_An1=feature( An);
          f_PH1=feature(PH);
                  
          f_An(k1:k1+3)=f_An1;
           f_PH(k1:k1+3)=f_PH1;
               k1=k1+4;
        end
        end       
          f= [ f_An, f_PH];    
    function f=feature(I)
Mask=I(logical(I));
Mean=mean(Mask);
Variance=var(Mask);
Kurtosis=kurtosis(Mask);
Skeweness=skewness(Mask);          
 f=[ Mean Variance Skeweness Kurtosis];