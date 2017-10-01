clear all;close all; clc;
w0 = 220; %基频率
index = 2^(1/12); 
basic = w0/index^4;
freq = 1:24; %all
freq(1) = basic;
for i = 2:24
    freq(i) = freq(i-1)*index;
end
fs = 8000;%sample rate
t1 = (1:fs/2)/fs;% 四分音符
t2 = (1:fs/4)/fs;% 八分音符
bF = sin(2*pi*freq(1)*t1);
bG = sin(2*pi*freq(3)*t1);
bA = sin(2*pi*freq(5)*t1);
bB = sin(2*pi*freq(7)*t1);
bC = sin(2*pi*freq(8)*t1);
bD = sin(2*pi*freq(10)*t1);
bE = sin(2*pi*freq(12)*t1);
F = sin(2*pi*freq(13)*t1);
G = sin(2*pi*freq(15)*t1);
A = sin(2*pi*freq(17)*t1);
B = sin(2*pi*freq(19)*t1);
C = sin(2*pi*freq(20)*t1);
D = sin(2*pi*freq(22)*t1);
E = sin(2*pi*freq(24)*t1);
hbF = sin(2*pi*freq(1)*t2);
hbG = sin(2*pi*freq(3)*t2);
hbA = sin(2*pi*freq(5)*t2);
hbB = sin(2*pi*freq(7)*t2);
hbC = sin(2*pi*freq(8)*t2);
hbD = sin(2*pi*freq(10)*t2);
hbE = sin(2*pi*freq(12)*t2);
hF = sin(2*pi*freq(13)*t2);
hG = sin(2*pi*freq(15)*t2);
hA = sin(2*pi*freq(17)*t2);
hB = sin(2*pi*freq(19)*t2);
hC = sin(2*pi*freq(20)*t2);
hD = sin(2*pi*freq(22)*t2);
hE = sin(2*pi*freq(24)*t2);

music = [C,hC,hD,G,G,F,hF,hbD,G,G];
sound(music)



