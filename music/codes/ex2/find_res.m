function [freq,data] = find_res(wave,fs)
tmp = wave;
for j = 1:10
   tmp = [tmp;tmp];
end
l = length(tmp);

F = fft(tmp,l)/l;
F = abs(F);
%f = (1:l/2)/l*fs;
%f = f';
%plot(f,2*abs(F(1:l/2)));

%{
m = max(F);
tm = find(F > m*0.4);
s = tm(1);
freq = s/l*fs;
%}
m_pos = find(F==max(F));
if (m_pos/l*fs>550)
    f1 = max(F(round(m_pos/2)-50:round(m_pos/2)+50));
    f2 = max(F(round(m_pos/3)-50:round(m_pos/3)+50));
    if(f1>f2)
        m_pos = round(m_pos/2);
    else
        m_pos = round(m_pos/3);
    end
end
freq = m_pos(1)/l*fs;
    
s = m_pos(1);
data = zeros(1,10);
i = 1;
while i <11
   p1 = round(i*s-s/2);
   p2 = round(i*s+s/2);
   tmp = F(p1:p2);
   m_1 = max(tmp);
   pos = find(tmp==m_1);
   data(i) = m_1;
   i = i+1;
end
stand = data(1);
data=data/stand;






