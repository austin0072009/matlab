clear all;
close all;
clc;
load Guitar.mat;
element = wave2proc;
fs = 8000;
%发现当叠加次数过大时频谱会变化
%分析原因在于这并不是标准的10个周期(243不可能被10整除)
%叠加1000次左右时非标准周期的误差被放大很大
%选择了128次比较合适的值
for j = 1:7
   element = [element;element];
end
l = length(element);

F = fft(element)/l;
F = abs(F);

f = (1:l/2)/l*fs;
f = f';
plot(f,2*abs(F(1:l/2)));

%后续为结果处理
m = max(F);
tmp = find(F>m*0.4);
s = tmp(1);
data = zeros(2,10);
i = 1;
while i <11
   p1 = round(i*s-s/2);
   p2 = round(i*s+s/2);
   tmp = F(p1:p2);
   m_1 = max(tmp);
   pos = find(tmp==m_1);
   data(1,i) = m_1;
   data(2,i) = pos+s*(i-1)+s/2;
   i = i+1;
end
data(2,:) = data(2,:)/l*fs;
stand = data(1,1);
data(1,:)=data(1,:)/stand;
