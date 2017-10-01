function eco = echo_audio_d(y,w)
%model: y(t)=x(t)+Ax(t-delay)+Bx(t-d2)+C...;
%利用DFT的性质解决此问题
N = length(y);
z = xcorr(y);
m1 = max(z);
A = 0;
B = 0;
C = 0;
delay1 = 0;
delay2 = 0;
delay3 = 0;

m = find(z == max(z));
width = w;
z(m-width:m+width-1)= 0 ;
m2 = max(z);
pos = find(z == max(z));
delay1 = abs(m-pos(1));  %回响延时
A = m2/m1;  %回响峰值
d_1 = m-delay1;
d_2 = m+delay1;
z(d_1-width:d_1+width-1)= 0 ;
z(d_2-width:d_2+width-1)= 0 ;
m3 = max(z);
pos = find(z == max(z));
B = m3/m1;
delay2 = abs(m-pos(1));
d_1 = m-delay2;
d_2 = m+delay2;
z(d_1-width:d_1+width-1)= 0 ;
z(d_2-width:d_2+width-1)= 0 ;
m4 = max(z);
pos = find(z == max(z));
C = m4/m1;
delay2 = abs(m-pos(1));

W = exp(-2i*pi/N);
tmp = 1:N;
tmp = A*W.^(-tmp*delay1)+B*W.^(-tmp*delay2)+C*W.^(-tmp*delay3)+1;
y1 = fft(y);
z1 = y1./tmp';
eco = real(ifft(z1));
