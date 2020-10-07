function coded = caesar(str,shift)
for i = 1:length(str)
    if str(i)+shift<32
        d = str(i)+rem(shift,95);
        if d<32
            d = 31 - d;
            coded(i) = char(126-d);
        else
            coded(i) = char(d);
        end
    elseif str(i)+shift>126
        d2 = str(i)+rem(shift,95);
        if d2>126
            d2=d2-126;
            coded(i) = char(31+d2);
        else
            coded(i) = char(d2);
        end
    else
        coded(i) = char(str(i)+shift);
    end
end