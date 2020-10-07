function o = blur(img,w)
[r,c] = size(img);
o = uint8(zeros(r,c));
for i = 1:r
    for j = 1:c
        f = [];
        if i-w<1 && j-w<1
            f = img(1:i+w,1:j+w);
        elseif i-w<1 && j+w>c
            f = img(1:i+w,j-w:c);
        elseif i+w>r && j-w<1
            f = img(i-w:r,1:j+w);
        elseif i+w>r && j+w>c
            f = img(i-w:r,j-w:c);
        elseif i-w<1
            f = img(1:i+w,j-w:j+w);
        elseif i+w>r
            f = img(i-w:r,j-w:j+w);
        elseif j-w<1
            f = img(i-w:i+w,1:j+w);
        elseif j+w>c
            f = img(i-w:i+w,j-w:c);
        else
            f = img(i-w:i+w,j-w:j+w);
        end 
        o(i,j) = uint8(mean(f(:)));
    end
end