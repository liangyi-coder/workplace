function im = bgfilling(im,bg,h,w)
for i = 1:h
    for j =1:w
        if im(i,j) == 0
            im(i,j) = bg;
        end
    end
end

end