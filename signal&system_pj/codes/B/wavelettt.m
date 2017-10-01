function xxd = wavelettt(input,index)
xd = wden(input,'heursure','s','mln',10,'bior4.4');
ave = mean(abs(xd));
x_d = (abs(xd)>index*ave);
xxd = (xd).*x_d; 
