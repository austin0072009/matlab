function eco = echo_audio(y,w)
%model: y(t)=x(t)+Ax(t-delay);
%����DFT�����ʽ��������
N = length(y);
z = xcorr(y);
m1 = max(z);
m = find(z == max(z));
width = w;
z(m-width:m+width-1)= 0 ;
m2 = max(z);
pos = find(z == max(z));
delay = abs(m-pos(1));  %������ʱ
A = m2/m1;  %�����ֵ
W = exp(-2i*pi/N);
tmp = 1:N;
tmp = A*W.^(-tmp*delay)+1;
y1 = fft(y);
z1 = y1./tmp';
eco = real(ifft(z1));
