function o = echo_gen(input, fs, delay, amp)
f = input;
f = [zeros(round(delay*fs),1);f];
f = f*amp;
input = [input;zeros(round(delay*fs),1)];
o = f+input;
for i = 1:length(o)
    if o(i)>1 || o(i)<-1
        o=o/abs(o(i));
    end
end
