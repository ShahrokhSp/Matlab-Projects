function charnum = char_counter(fname,character)
fid = fopen(fname,'r+t');
if fid < 0 || ~ischar(character)
    charnum = -1;
    return
end
counter = 0;
line = fgets(fid);
while ischar(line)
    s = sum(line == character);
    counter = counter + s;
end
charnum = counter;
end