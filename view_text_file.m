function view_text_file(filename)
fid = fopen(filename,'rt');
if fid <0
    error('error opening file %s\n', filename)
end
oneline = fgets(fid);
while ischar(oneline)
    fprintf('%s',oneline)
    oneline = fgets(fid);
end
fprintf('\n');
fclose(fid);