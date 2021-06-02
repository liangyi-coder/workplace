function features = wldfeatures( m )



[M,N,K]=size(m);
energy=0;%f1
contrast=0;%f2
homogeneity=0;%f3
entropy=0;%f4
dissimilarity=0;%f5
maxProbability=0;%f6
inversDifference=0;%f7

    for i=1:M
        for j=1:N
            maxProbability=max(m(:));
            if m(i,j)
                f1=m(i,j)^2;
                energy=f1+energy;
                
                f2=(i-j)^2*m(i,j);
                contrast=f2+contrast;
                
                f3=1/(1+(i-j)^2)*m(i,j);
                homogeneity=f3+homogeneity;
                
                f4=m(i,j)*log10(m(i,j));
                entropy=f4+entropy;                
                
                f5=m(i,j)*abs(i-j);
                dissimilarity=f5+dissimilarity;
                
                f7=m(i,j)/(1+abs(i-j));
                inversDifference=f7+inversDifference;
            end
                
        end
    end
    features=[energy contrast homogeneity entropy dissimilarity maxProbability inversDifference];
end