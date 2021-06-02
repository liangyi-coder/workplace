function [ DE1,ORT1 ] = WLD( img,ibw )
%DE=differential excitation;
%ORT=orientation;
f00=[1,1,1;1,-8,1;1,1,1];
f01=[0,0,0;0,1,0;0,0,0];
f10=[0,-1,0;0,0,0;0,1,0];
f11=[0,0,0;1,0,-1;0,0,0];
T=8;
[m,n]=size(img);
 id=1;io=1;
    for i=2:m-1
        jj=1;
        de=[];
        angular=[];
        for j=2:n-1
            if ibw(i,j)
                vs00=sum(sum(img(i-1:i+1,j-1:j+1).*f00));
                vs01=sum(sum(img(i-1:i+1,j-1:j+1).*f01));
                vs10=sum(sum(img(i-1:i+1,j-1:j+1).*f10));
                vs11=sum(sum(img(i-1:i+1,j-1:j+1).*f11));
                de(1,jj)=atan(vs00/vs01);%atan的结果是弧度
                angular(1,jj)=atan2(vs11,vs00)+pi;
                jj=jj+1;
                DE1(i,j)=atan(vs00/vs01);
                ORT1(i,j)=atan2(vs11,vs00)+pi;
            end
        end
        if isempty(de)
        else
            DE{id}=de;
            id=id+1;
        end
        if isempty(angular)
        else
            ORT{io}=angular;
            io=io+1;
        end         
    end
    l=length(ORT);
%     for i=1:l
for i=1:size(ORT1,1)
%         ort=ORT{i};
%         m=length(ort);
%         for j=1:m
 for j=1:size(ORT1,2)
     ort(1,j)=ORT1(i,j);
            if ort(1,j)<0.25*pi
                ort(1,j)=0;
            elseif ort(1,j)<0.5*pi
                ort(1,j)=0.25*pi;
            elseif ort(1,j)<0.75*pi
                ort(1,j)=0.5*pi;
            elseif ort(1,j)<pi
                ort(1,j)=0.75*pi;
            elseif ort(1,j)<1.25*pi
                ort(1,j)=pi;
            elseif ort(1,j)<1.5*pi
                ort(1,j)=1.25*pi;
            elseif ort(1,j)<1.75*pi
                ort(1,j)=1.5*pi;
            else
                ort(1,j)=1.75*pi;
            end
             ORT1(i,j)=ort(1,j);
        end
%         ORT{i}=ort;
    end
                    
end

     


