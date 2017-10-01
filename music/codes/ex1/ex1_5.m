clear all;close all; clc;

w0 = 220; %基频率
index1 = 2^(1/12); 
basic = w0/index1^4;
freq = 1:24; %all
freq(1) = basic;
for i = 2:24
    freq(i) = freq(i-1)*index1;
end
freq2 = freq/2;
fs = 10000;%sample rate
t0 = (1:fs);%二分音符
t1 = (1:fs/2);% 四分音符
t2 = (1:fs/4);% 八分音符
t3 = (1:3*fs/2);
t4 = (1:5*fs/2);
%cover0 = exp(-t0/fs*2);
%cover1 = exp(-t1/fs*4);
%cover2 = exp(-t2/fs*8);

%y = 1./(0.04/sample*t+1./(3200/sample*t));
a = 0.1;
b = 3500;

cover3 = 1./(2*a/fs*t3/3+1./(2*b/fs*t3/3));
k3 = 4./(a*9/8+1./(b*9/8))/fs;
tt3 = (9/8*fs+1:3*fs/2);
cover3(9*fs/8+1:3*fs/2) = -k3*(tt3-3*fs/2);
cover3 = cover3/max(cover3);

cover4 = 1./(2*a/fs*t4/5+1./(2*b/fs*t4/5));
k4 = 4./(a*15/8+1./(b*15/8))/fs;
tt4 = (15/8*fs+1:5*fs/2);
cover4(15*fs/8+1:5*fs/2) = -k4*(tt4-5*fs/2);
cover4 = cover4/max(cover4);

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



PB = 0.2;
PC = 0.3;

bF = (sin(2*pi*freq(1)*t1/fs)+PB*sin(4*pi*freq(1)*t1/fs)+PC*sin(6*pi*freq(1)*t1/fs)).*cover1;
bG = (sin(2*pi*freq(3)*t1/fs)+PB*sin(4*pi*freq(3)*t1/fs)+PC*sin(6*pi*freq(3)*t1/fs)).*cover1;
bA = (sin(2*pi*freq(5)*t1/fs)+PB*sin(4*pi*freq(5)*t1/fs)+PC*sin(6*pi*freq(5)*t1/fs)).*cover1;
bB = (sin(2*pi*freq(7)*t1/fs)+PB*sin(4*pi*freq(7)*t1/fs)+PC*sin(6*pi*freq(7)*t1/fs)).*cover1;
bC = (sin(2*pi*freq(8)*t1/fs)+PB*sin(4*pi*freq(8)*t1/fs)+PC*sin(6*pi*freq(8)*t1/fs)).*cover1;
bD = (sin(2*pi*freq(10)*t1/fs)+PB*sin(4*pi*freq(10)*t1/fs)+PC*sin(6*pi*freq(10)*t1/fs)).*cover1;
bE = (sin(2*pi*freq(12)*t1/fs)+PB*sin(4*pi*freq(12)*t1/fs)+PC*sin(6*pi*freq(12)*t1/fs)).*cover1;
F = (sin(2*pi*freq(13)*t1/fs)+PB*sin(4*pi*freq(13)*t1/fs)+PC*sin(6*pi*freq(13)*t1/fs)).*cover1;
G = (sin(2*pi*freq(15)*t1/fs)+PB*sin(4*pi*freq(15)*t1/fs)+PC*sin(6*pi*freq(15)*t1/fs)).*cover1;
A = (sin(2*pi*freq(17)*t1/fs)+PB*sin(4*pi*freq(17)*t1/fs)+PC*sin(6*pi*freq(17)*t1/fs)).*cover1;
B = (sin(2*pi*freq(19)*t1/fs)+PB*sin(4*pi*freq(19)*t1/fs)+PC*sin(6*pi*freq(19)*t1/fs)).*cover1;
C = (sin(2*pi*freq(20)*t1/fs)+PB*sin(4*pi*freq(20)*t1/fs)+PC*sin(6*pi*freq(20)*t1/fs)).*cover1;
D = (sin(2*pi*freq(22)*t1/fs)+PB*sin(4*pi*freq(22)*t1/fs)+PC*sin(6*pi*freq(22)*t1/fs)).*cover1;
E = (sin(2*pi*freq(24)*t1/fs)+PB*sin(4*pi*freq(24)*t1/fs)+PC*sin(6*pi*freq(24)*t1/fs)).*cover1;

wbF = (sin(2*pi*freq(1)*t0/fs)+PB*sin(4*pi*freq(1)*t0/fs)+PC*sin(6*pi*freq(1)*t0/fs)).*cover0;
wbG = (sin(2*pi*freq(3)*t0/fs)+PB*sin(4*pi*freq(3)*t0/fs)+PC*sin(6*pi*freq(3)*t0/fs)).*cover0;
wbA = (sin(2*pi*freq(5)*t0/fs)+PB*sin(4*pi*freq(5)*t0/fs)+PC*sin(6*pi*freq(5)*t0/fs)).*cover0;
wbB = (sin(2*pi*freq(7)*t0/fs)+PB*sin(4*pi*freq(7)*t0/fs)+PC*sin(6*pi*freq(7)*t0/fs)).*cover0;
wbC = (sin(2*pi*freq(8)*t0/fs)+PB*sin(4*pi*freq(8)*t0/fs)+PC*sin(6*pi*freq(8)*t0/fs)).*cover0;
wbD = (sin(2*pi*freq(10)*t0/fs)+PB*sin(4*pi*freq(10)*t0/fs)+PC*sin(6*pi*freq(10)*t0/fs)).*cover0;
wbE = (sin(2*pi*freq(12)*t0/fs)+PB*sin(4*pi*freq(12)*t0/fs)+PC*sin(6*pi*freq(12)*t0/fs)).*cover0;
wF = (sin(2*pi*freq(13)*t0/fs)+PB*sin(4*pi*freq(13)*t0/fs)+PC*sin(6*pi*freq(13)*t0/fs)).*cover0;
wG = (sin(2*pi*freq(15)*t0/fs)+PB*sin(4*pi*freq(15)*t0/fs)+PC*sin(6*pi*freq(15)*t0/fs)).*cover0;
wA = (sin(2*pi*freq(17)*t0/fs)+PB*sin(4*pi*freq(17)*t0/fs)+PC*sin(6*pi*freq(17)*t0/fs)).*cover0;
wB = (sin(2*pi*freq(19)*t0/fs)+PB*sin(4*pi*freq(19)*t0/fs)+PC*sin(6*pi*freq(19)*t0/fs)).*cover0;
wC = (sin(2*pi*freq(20)*t0/fs)+PB*sin(4*pi*freq(20)*t0/fs)+PC*sin(6*pi*freq(20)*t0/fs)).*cover0;
wD = (sin(2*pi*freq(22)*t0/fs)+PB*sin(4*pi*freq(22)*t0/fs)+PC*sin(6*pi*freq(22)*t0/fs)).*cover0;
wE = (sin(2*pi*freq(24)*t0/fs)+PB*sin(4*pi*freq(24)*t0/fs)+PC*sin(6*pi*freq(24)*t0/fs)).*cover0;

xbF = (sin(2*pi*freq(1)*t3/fs)+PB*sin(4*pi*freq(1)*t3/fs)+PC*sin(6*pi*freq(1)*t3/fs)).*cover3;
xbG = (sin(2*pi*freq(3)*t3/fs)+PB*sin(4*pi*freq(3)*t3/fs)+PC*sin(6*pi*freq(3)*t3/fs)).*cover3;
xbA = (sin(2*pi*freq(5)*t3/fs)+PB*sin(4*pi*freq(5)*t3/fs)+PC*sin(6*pi*freq(5)*t3/fs)).*cover3;
xbB = (sin(2*pi*freq(7)*t3/fs)+PB*sin(4*pi*freq(7)*t3/fs)+PC*sin(6*pi*freq(7)*t3/fs)).*cover3;
xbC = (sin(2*pi*freq(8)*t3/fs)+PB*sin(4*pi*freq(8)*t3/fs)+PC*sin(6*pi*freq(8)*t3/fs)).*cover3;
xbD = (sin(2*pi*freq(10)*t3/fs)+PB*sin(4*pi*freq(10)*t3/fs)+PC*sin(6*pi*freq(10)*t3/fs)).*cover3;
xbE = (sin(2*pi*freq(12)*t3/fs)+PB*sin(4*pi*freq(12)*t3/fs)+PC*sin(6*pi*freq(12)*t3/fs)).*cover3;
xF = (sin(2*pi*freq(13)*t3/fs)+PB*sin(4*pi*freq(13)*t3/fs)+PC*sin(6*pi*freq(13)*t3/fs)).*cover3;
xG = (sin(2*pi*freq(15)*t3/fs)+PB*sin(4*pi*freq(15)*t3/fs)+PC*sin(6*pi*freq(15)*t3/fs)).*cover3;
xA = (sin(2*pi*freq(17)*t3/fs)+PB*sin(4*pi*freq(17)*t3/fs)+PC*sin(6*pi*freq(17)*t3/fs)).*cover3;
xB = (sin(2*pi*freq(19)*t3/fs)+PB*sin(4*pi*freq(19)*t3/fs)+PC*sin(6*pi*freq(19)*t3/fs)).*cover3;
xC = (sin(2*pi*freq(20)*t3/fs)+PB*sin(4*pi*freq(20)*t3/fs)+PC*sin(6*pi*freq(20)*t3/fs)).*cover3;
xD = (sin(2*pi*freq(22)*t3/fs)+PB*sin(4*pi*freq(22)*t3/fs)+PC*sin(6*pi*freq(22)*t3/fs)).*cover3;
xE = (sin(2*pi*freq(24)*t3/fs)+PB*sin(4*pi*freq(24)*t3/fs)+PC*sin(6*pi*freq(24)*t3/fs)).*cover3;

hbF = (sin(2*pi*freq(1)*t2/fs)+PB*sin(4*pi*freq(1)*t2/fs)+PC*sin(6*pi*freq(1)*t2/fs)).*cover2;
hbG = (sin(2*pi*freq(3)*t2/fs)+PB*sin(4*pi*freq(3)*t2/fs)+PC*sin(6*pi*freq(3)*t2/fs)).*cover2;
hbA = (sin(2*pi*freq(5)*t2/fs)+PB*sin(4*pi*freq(5)*t2/fs)+PC*sin(6*pi*freq(5)*t2/fs)).*cover2;
hbB = (sin(2*pi*freq(7)*t2/fs)+PB*sin(4*pi*freq(7)*t2/fs)+PC*sin(6*pi*freq(7)*t2/fs)).*cover2;
hbC = (sin(2*pi*freq(8)*t2/fs)+PB*sin(4*pi*freq(8)*t2/fs)+PC*sin(6*pi*freq(8)*t2/fs)).*cover2;
hbD = (sin(2*pi*freq(10)*t2/fs)+PB*sin(4*pi*freq(10)*t2/fs)+PC*sin(6*pi*freq(10)*t2/fs)).*cover2;
hbE = (sin(2*pi*freq(12)*t2/fs)+PB*sin(4*pi*freq(12)*t2/fs)+PC*sin(6*pi*freq(12)*t2/fs)).*cover2;
hF = (sin(2*pi*freq(13)*t2/fs)+PB*sin(4*pi*freq(13)*t2/fs)+PC*sin(6*pi*freq(13)*t2/fs)).*cover2;
hG = (sin(2*pi*freq(15)*t2/fs)+PB*sin(4*pi*freq(15)*t2/fs)+PC*sin(6*pi*freq(15)*t2/fs)).*cover2;
hA = (sin(2*pi*freq(17)*t2/fs)+PB*sin(4*pi*freq(17)*t2/fs)+PC*sin(6*pi*freq(17)*t2/fs)).*cover2;
hB = (sin(2*pi*freq(19)*t2/fs)+PB*sin(4*pi*freq(19)*t2/fs)+PC*sin(6*pi*freq(19)*t2/fs)).*cover2;
hC = (sin(2*pi*freq(20)*t2/fs)+PB*sin(4*pi*freq(20)*t2/fs)+PC*sin(6*pi*freq(20)*t2/fs)).*cover2;
hD = (sin(2*pi*freq(22)*t2/fs)+PB*sin(4*pi*freq(22)*t2/fs)+PC*sin(6*pi*freq(22)*t2/fs)).*cover2;
hE = (sin(2*pi*freq(24)*t2/fs)+PB*sin(4*pi*freq(24)*t2/fs)+PC*sin(6*pi*freq(24)*t2/fs)).*cover2;
mC = (sin(2*pi*freq(20)*t4/fs)+PB*sin(4*pi*freq(20)*t4/fs)+PC*sin(6*pi*freq(20)*t4/fs)).*cover4;


c = 1;
d = 100;

cover33 = 1./(2*c/fs*t3/3+1./(2*d/fs*t3/3));
k33 = 4./(c*9/8+1./(d*9/8))/fs;
tt33 = (9/8*fs+1:3*fs/2);
cover33(9*fs/8+1:3*fs/2) = -k33*(tt33-3*fs/2);
cover33 = cover33/max(cover33);

cover44 = 1./(2*c/fs*t4/5+1./(2*d/fs*t4/5));
k44 = 4./(c*15/8+1./(d*15/8))/fs;
tt44 = (15/8*fs+1:5*fs/2);
cover44(15*fs/8+1:5*fs/2) = -k44*(tt44-5*fs/2);
cover44 = cover44/max(cover44);

cover00 = 1./(c/fs*t0+1./(d/fs*t0));
k00 = 4./(c*3/4+1./(d*3/4))/fs;
tt00 = (3/4*fs+1:fs);
cover00(3*fs/4+1:fs) = -k00*(tt00-fs);
cover00 = cover00/max(cover00);

cover11 = 1./(2*c/fs*t1+1./(2*d/fs*t1));
k11 = 4./(c*3/8+1./(d*3/8))/fs;
tt11 = (3/8*fs+1:fs/2);
cover11(3*fs/8+1:fs/2) = -k11*(tt11-fs/2);
cover11 = cover11/max(cover11);

cover22 = 1./(4*c/fs*t2+1./(4*d/fs*t2));
k22 = 4./(c*3/16+1./(d*3/16))/fs;
tt22 = (3/16*fs+1:fs/4);
cover22(3*fs/16+1:fs/4) = -k22*(tt22-fs/4);
cover22 = cover22/max(cover22);


index1 = 0.4;
index2 = 0.6;

bF = index2*bF+index1*(sin(2*pi*freq2(1)*t1/fs)+PB*sin(4*pi*freq2(1)*t1/fs)+PC*sin(6*pi*freq2(1)*t1/fs)).*cover11;
bG = index2*bG+index1*(sin(2*pi*freq2(3)*t1/fs)+PB*sin(4*pi*freq2(3)*t1/fs)+PC*sin(6*pi*freq2(3)*t1/fs)).*cover11;
bA = index2*bA+index1*(sin(2*pi*freq2(5)*t1/fs)+PB*sin(4*pi*freq2(5)*t1/fs)+PC*sin(6*pi*freq2(5)*t1/fs)).*cover11;
bB = index2*bB+index1*(sin(2*pi*freq2(7)*t1/fs)+PB*sin(4*pi*freq2(7)*t1/fs)+PC*sin(6*pi*freq2(7)*t1/fs)).*cover11;
bC = index2*bC+index1*(sin(2*pi*freq2(8)*t1/fs)+PB*sin(4*pi*freq2(8)*t1/fs)+PC*sin(6*pi*freq2(8)*t1/fs)).*cover11;
bD = index2*bD+index1*(sin(2*pi*freq2(10)*t1/fs)+PB*sin(4*pi*freq2(10)*t1/fs)+PC*sin(6*pi*freq2(10)*t1/fs)).*cover11;
bE = index2*bE+index1*(sin(2*pi*freq2(12)*t1/fs)+PB*sin(4*pi*freq2(12)*t1/fs)+PC*sin(6*pi*freq2(12)*t1/fs)).*cover11;
F = index2*F+index1*(sin(2*pi*freq2(13)*t1/fs)+PB*sin(4*pi*freq2(13)*t1/fs)+PC*sin(6*pi*freq2(13)*t1/fs)).*cover11;
G = index2*G+index1*(sin(2*pi*freq2(15)*t1/fs)+PB*sin(4*pi*freq2(15)*t1/fs)+PC*sin(6*pi*freq2(15)*t1/fs)).*cover11;
A = index2*A+index1*(sin(2*pi*freq2(17)*t1/fs)+PB*sin(4*pi*freq2(17)*t1/fs)+PC*sin(6*pi*freq2(17)*t1/fs)).*cover11;
B = index2*B+index1*(sin(2*pi*freq2(19)*t1/fs)+PB*sin(4*pi*freq2(19)*t1/fs)+PC*sin(6*pi*freq2(19)*t1/fs)).*cover11;
C = index2*C+index1*(sin(2*pi*freq2(20)*t1/fs)+PB*sin(4*pi*freq2(20)*t1/fs)+PC*sin(6*pi*freq2(20)*t1/fs)).*cover11;
D = index2*D+index1*(sin(2*pi*freq2(22)*t1/fs)+PB*sin(4*pi*freq2(22)*t1/fs)+PC*sin(6*pi*freq2(22)*t1/fs)).*cover11;
E = index2*E+index1*(sin(2*pi*freq2(24)*t1/fs)+PB*sin(4*pi*freq2(24)*t1/fs)+PC*sin(6*pi*freq2(24)*t1/fs)).*cover11;

wbF = index2*wbF+index1*(sin(2*pi*freq2(1)*t0/fs)+PB*sin(4*pi*freq2(1)*t0/fs)+PC*sin(6*pi*freq2(1)*t0/fs)).*cover0;
wbG = index2*wbG+index1*(sin(2*pi*freq2(3)*t0/fs)+PB*sin(4*pi*freq2(3)*t0/fs)+PC*sin(6*pi*freq2(3)*t0/fs)).*cover0;
wbA = index2*wbA+index1*(sin(2*pi*freq2(5)*t0/fs)+PB*sin(4*pi*freq2(5)*t0/fs)+PC*sin(6*pi*freq2(5)*t0/fs)).*cover0;
wbB = index2*wbB+index1*(sin(2*pi*freq2(7)*t0/fs)+PB*sin(4*pi*freq2(7)*t0/fs)+PC*sin(6*pi*freq2(7)*t0/fs)).*cover0;
wbC = index2*wbC+index1*(sin(2*pi*freq2(8)*t0/fs)+PB*sin(4*pi*freq2(8)*t0/fs)+PC*sin(6*pi*freq2(8)*t0/fs)).*cover0;
wbD = index2*wbD+index1*(sin(2*pi*freq2(10)*t0/fs)+PB*sin(4*pi*freq2(10)*t0/fs)+PC*sin(6*pi*freq2(10)*t0/fs)).*cover0;
wbE = index2*wbE+index1*(sin(2*pi*freq2(12)*t0/fs)+PB*sin(4*pi*freq2(12)*t0/fs)+PC*sin(6*pi*freq2(12)*t0/fs)).*cover0;
wF = index2*wF+index1*(sin(2*pi*freq2(13)*t0/fs)+PB*sin(4*pi*freq2(13)*t0/fs)+PC*sin(6*pi*freq2(13)*t0/fs)).*cover0;
wG = index2*wG+index1*(sin(2*pi*freq2(15)*t0/fs)+PB*sin(4*pi*freq2(15)*t0/fs)+PC*sin(6*pi*freq2(15)*t0/fs)).*cover0;
wA = index2*wA+index1*(sin(2*pi*freq2(17)*t0/fs)+PB*sin(4*pi*freq2(17)*t0/fs)+PC*sin(6*pi*freq2(17)*t0/fs)).*cover0;
wB = index2*wB+index1*(sin(2*pi*freq2(19)*t0/fs)+PB*sin(4*pi*freq2(19)*t0/fs)+PC*sin(6*pi*freq2(19)*t0/fs)).*cover0;
wC = index2*wC+index1*(sin(2*pi*freq2(20)*t0/fs)+PB*sin(4*pi*freq2(20)*t0/fs)+PC*sin(6*pi*freq2(20)*t0/fs)).*cover0;
wD = index2*wD+index1*(sin(2*pi*freq2(22)*t0/fs)+PB*sin(4*pi*freq2(22)*t0/fs)+PC*sin(6*pi*freq2(22)*t0/fs)).*cover0;
wE = index2*wE+index1*(sin(2*pi*freq2(24)*t0/fs)+PB*sin(4*pi*freq2(24)*t0/fs)+PC*sin(6*pi*freq2(24)*t0/fs)).*cover0;

xbF = index2*xbF+index1*(sin(2*pi*freq2(1)*t3/fs)+PB*sin(4*pi*freq2(1)*t3/fs)+PC*sin(6*pi*freq2(1)*t3/fs)).*cover33;
xbG = index2*xbF+index1*(sin(2*pi*freq2(3)*t3/fs)+PB*sin(4*pi*freq2(3)*t3/fs)+PC*sin(6*pi*freq2(3)*t3/fs)).*cover33;
xbA = index2*xbA+index1*(sin(2*pi*freq2(5)*t3/fs)+PB*sin(4*pi*freq2(5)*t3/fs)+PC*sin(6*pi*freq2(5)*t3/fs)).*cover33;
xbB = index2*xbB+index1*(sin(2*pi*freq2(7)*t3/fs)+PB*sin(4*pi*freq2(7)*t3/fs)+PC*sin(6*pi*freq2(7)*t3/fs)).*cover33;
xbC = index2*xbC+index1*(sin(2*pi*freq2(8)*t3/fs)+PB*sin(4*pi*freq2(8)*t3/fs)+PC*sin(6*pi*freq2(8)*t3/fs)).*cover33;
xbD = index2*xbD+index1*(sin(2*pi*freq2(10)*t3/fs)+PB*sin(4*pi*freq2(10)*t3/fs)+PC*sin(6*pi*freq2(10)*t3/fs)).*cover33;
xbE = index2*xbE+index1*(sin(2*pi*freq2(12)*t3/fs)+PB*sin(4*pi*freq2(12)*t3/fs)+PC*sin(6*pi*freq2(12)*t3/fs)).*cover33;
xF = index2*xF+index1*(sin(2*pi*freq2(13)*t3/fs)+PB*sin(4*pi*freq2(13)*t3/fs)+PC*sin(6*pi*freq2(13)*t3/fs)).*cover33;
xG = index2*xG+index1*(sin(2*pi*freq2(15)*t3/fs)+PB*sin(4*pi*freq2(15)*t3/fs)+PC*sin(6*pi*freq2(15)*t3/fs)).*cover33;
xA = index2*xA+index1*(sin(2*pi*freq2(17)*t3/fs)+PB*sin(4*pi*freq2(17)*t3/fs)+PC*sin(6*pi*freq2(17)*t3/fs)).*cover33;
xB = index2*xB+index1*(sin(2*pi*freq2(19)*t3/fs)+PB*sin(4*pi*freq2(19)*t3/fs)+PC*sin(6*pi*freq2(19)*t3/fs)).*cover33;
xC = index2*xC+index1*(sin(2*pi*freq2(20)*t3/fs)+PB*sin(4*pi*freq2(20)*t3/fs)+PC*sin(6*pi*freq2(20)*t3/fs)).*cover33;
xD = index2*xD+index1*(sin(2*pi*freq2(22)*t3/fs)+PB*sin(4*pi*freq2(22)*t3/fs)+PC*sin(6*pi*freq2(22)*t3/fs)).*cover33;
xE = index2*xE+index1*(sin(2*pi*freq2(24)*t3/fs)+PB*sin(4*pi*freq2(24)*t3/fs)+PC*sin(6*pi*freq2(24)*t3/fs)).*cover33;

hbF = index2*hbF+index1*(sin(2*pi*freq2(1)*t2/fs)+PB*sin(4*pi*freq2(1)*t2/fs)+PC*sin(6*pi*freq2(1)*t2/fs)).*cover22;
hbG = index2*hbG+index1*(sin(2*pi*freq2(3)*t2/fs)+PB*sin(4*pi*freq2(3)*t2/fs)+PC*sin(6*pi*freq2(3)*t2/fs)).*cover22;
hbA = index2*hbA+index1*(sin(2*pi*freq2(5)*t2/fs)+PB*sin(4*pi*freq2(5)*t2/fs)+PC*sin(6*pi*freq2(5)*t2/fs)).*cover22;
hbB = index2*hbB+index1*(sin(2*pi*freq2(7)*t2/fs)+PB*sin(4*pi*freq2(7)*t2/fs)+PC*sin(6*pi*freq2(7)*t2/fs)).*cover22;
hbC = index2*hbC+index1*(sin(2*pi*freq2(8)*t2/fs)+PB*sin(4*pi*freq2(8)*t2/fs)+PC*sin(6*pi*freq2(8)*t2/fs)).*cover22;
hbD = index2*hbD+index1*(sin(2*pi*freq2(10)*t2/fs)+PB*sin(4*pi*freq2(10)*t2/fs)+PC*sin(6*pi*freq2(10)*t2/fs)).*cover22;
hbE = index2*hbE+index1*(sin(2*pi*freq2(12)*t2/fs)+PB*sin(4*pi*freq2(12)*t2/fs)+PC*sin(6*pi*freq2(12)*t2/fs)).*cover22;
hF = index2*hF+index1*(sin(2*pi*freq2(13)*t2/fs)+PB*sin(4*pi*freq2(13)*t2/fs)+PC*sin(6*pi*freq2(13)*t2/fs)).*cover22;
hG = index2*hG+index1*(sin(2*pi*freq2(15)*t2/fs)+PB*sin(4*pi*freq2(15)*t2/fs)+PC*sin(6*pi*freq2(15)*t2/fs)).*cover22;
hA = index2*hA+index1*(sin(2*pi*freq2(17)*t2/fs)+PB*sin(4*pi*freq2(17)*t2/fs)+PC*sin(6*pi*freq2(17)*t2/fs)).*cover22;
hB = index2*hB+index1*(sin(2*pi*freq2(19)*t2/fs)+PB*sin(4*pi*freq2(19)*t2/fs)+PC*sin(6*pi*freq2(19)*t2/fs)).*cover22;
hC = index2*hC+index1*(sin(2*pi*freq2(20)*t2/fs)+PB*sin(4*pi*freq2(20)*t2/fs)+PC*sin(6*pi*freq2(20)*t2/fs)).*cover22;
hD = index2*hD+index1*(sin(2*pi*freq2(22)*t2/fs)+PB*sin(4*pi*freq2(22)*t2/fs)+PC*sin(6*pi*freq2(22)*t2/fs)).*cover22;
hE = index2*hE+index1*(sin(2*pi*freq2(24)*t2/fs)+PB*sin(4*pi*freq2(24)*t2/fs)+PC*sin(6*pi*freq2(24)*t2/fs)).*cover22;

mC = index2*mC+index1*(sin(2*pi*freq2(20)*t4/fs)+PB*sin(4*pi*freq2(20)*t4/fs)+PC*sin(6*pi*freq2(20)*t4/fs)).*cover44;
blank = [i:fs/4]*0;

%Y - = w; ___ = h;Y - - = x
music1 = [wbE,G,xD,wC,G,xF,wbE,bE];
music2 = [bE,F,G,xA,xG,wbE,G,xD];
music3 = [wC,G,xF,wbE,G,G,A,B,xC];
music4 = [xC,hD,blank,blank,hG,G,B,A,G,wbE,G,xC];
music5 = [wA,C,wD,C,wB,B,xG,wbE,G];
music6 = [wD,blank,blank,wC,G,xF,wbE,G];
music7 = [G,A,B,mC,blank,blank,mC,blank,blank,bC];
music = [music1,music2,music3,music4,music5,music6,music7];
delay1 = 1000;
delay2 = 1500;
zeo1 = zeros(1,delay1);
zeo2 = zeros(1,delay2);
l = length(music);
m_1 = [zeo1,music(1:l-delay1)];
m_2 = [zeo2,music(1:l-delay2)];
music = music + 0.2*m_1+0.3*m_2;
plot(music);
sound(music,96/120*fs);
%audiowrite('1_5.wav',music,96/120*fs);