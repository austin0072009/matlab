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
t0 = (1:fs);%二分音符
t1 = (1:fs/2);% 四分音符
t2 = (1:fs/4);% 八分音符
%cover0 = exp(-t0/fs*2);
%cover1 = exp(-t1/fs*4);
%cover2 = exp(-t2/fs*8);

%y = 1./(0.04/sample*t+1./(3200/sample*t));
a = 0.1;
b = 3500;
cover0 = 1./(a/fs*t0+1./(b/fs*t0));
k0 = 4./(a*3/4+1./(b*3/4))/fs;
tt0 = (3/4*fs+1:fs);
cover0(3*fs/4+1:fs) = -k0*(tt0-fs);
cover0 = cover0/max(cover0);
cover1 = 1./(2*a/fs*t1+1./(2*b/fs*t1));
k1 = 4./(a*3/8+1./(b*3/8))/fs;
tt1 = (3/8*fs+1:fs/2);
cover1(3*fs/8+1:fs/2) = -k1*(tt1-fs/2);
cover1 = cover1/max(cover1);
cover2 = 1./(4*a/fs*t2+1./(4*b/fs*t2));
k2 = 4./(a*3/16+1./(b*3/16))/fs;
tt2 = (3/16*fs+1:fs/4);
cover2(3*fs/16+1:fs/4) = -k2*(tt2-fs/4);
cover2 = cover2/max(cover2);

wbF = sin(2*pi*freq(1)*t0/fs).*cover0;
wbG = sin(2*pi*freq(3)*t0/fs).*cover0;
wbA = sin(2*pi*freq(5)*t0/fs).*cover0;
wbB = sin(2*pi*freq(7)*t0/fs).*cover0;
wbC = sin(2*pi*freq(8)*t0/fs).*cover0;
wbD = sin(2*pi*freq(10)*t0/fs).*cover0;
wbE = sin(2*pi*freq(12)*t0/fs).*cover0;
wF = sin(2*pi*freq(13)*t0/fs).*cover0;
wG = sin(2*pi*freq(15)*t0/fs).*cover0;
wA = sin(2*pi*freq(17)*t0/fs).*cover0;
wB = sin(2*pi*freq(19)*t0/fs).*cover0;
wC = sin(2*pi*freq(20)*t0/fs).*cover0;
wD = sin(2*pi*freq(22)*t0/fs).*cover0;
wE = sin(2*pi*freq(24)*t0/fs).*cover0;

bF = sin(2*pi*freq(1)*t1/fs).*cover1;
bG = sin(2*pi*freq(3)*t1/fs).*cover1;
bA = sin(2*pi*freq(5)*t1/fs).*cover1;
bB = sin(2*pi*freq(7)*t1/fs).*cover1;
bC = sin(2*pi*freq(8)*t1/fs).*cover1;
bD = sin(2*pi*freq(10)*t1/fs).*cover1;
bE = sin(2*pi*freq(12)*t1/fs).*cover1;
F = sin(2*pi*freq(13)*t1/fs).*cover1;
G = sin(2*pi*freq(15)*t1/fs).*cover1;
A = sin(2*pi*freq(17)*t1/fs).*cover1;
B = sin(2*pi*freq(19)*t1/fs).*cover1;
C = sin(2*pi*freq(20)*t1/fs).*cover1;
D = sin(2*pi*freq(22)*t1/fs).*cover1;
E = sin(2*pi*freq(24)*t1/fs).*cover1;
hbF = sin(2*pi*freq(1)*t2/fs).*cover2;
hbG = sin(2*pi*freq(3)*t2/fs).*cover2;
hbA = sin(2*pi*freq(5)*t2/fs).*cover2;
hbB = sin(2*pi*freq(7)*t2/fs).*cover2;
hbC = sin(2*pi*freq(8)*t2/fs).*cover2;
hbD = sin(2*pi*freq(10)*t2/fs).*cover2;
hbE = sin(2*pi*freq(12)*t2/fs).*cover2;
hF = sin(2*pi*freq(13)*t2/fs).*cover2;
hG = sin(2*pi*freq(15)*t2/fs).*cover2;
hA = sin(2*pi*freq(17)*t2/fs).*cover2;
hB = sin(2*pi*freq(19)*t2/fs).*cover2;
hC = sin(2*pi*freq(20)*t2/fs).*cover2;
hD = sin(2*pi*freq(22)*t2/fs).*cover2;
hE = sin(2*pi*freq(24)*t2/fs).*cover2;

music = [C,hC,hD,wG,F,hF,hbD,wG];
%plot (music)
sound(music,2*fs);
clear sound;
music2 = resample(music,10000,round((10000*2^(1/12))));
sound(music2);