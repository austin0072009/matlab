clear all;
close all;
clc;
load ex2_3.mat;

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

list = [1,3,5,7,8,10,12,13,15,17,19,20,22,24];
music_base0 = [];
music_base1 = [];
music_base2 = [];
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
for i = 1:14
    tt0 = sin(2*pi*freq(list(i))*t0/fs);
    tt1 = sin(2*pi*freq(list(i))*t1/fs);
    tt2 = sin(2*pi*freq(list(i))*t2/fs);
    for j = 2:10
        tt0 = tt0+data(1,j)*sin(2*j*pi*freq(list(i))*t0/fs);
        tt1 = tt1+data(1,j)*sin(2*j*pi*freq(list(i))*t1/fs);
        tt2 = tt2+data(1,j)*sin(2*j*pi*freq(list(i))*t2/fs);
    end
    tt0 = tt0.*cover0;
    tt1 = tt1.*cover1;
    tt2 = tt2.*cover2;
    music_base0 = [music_base0;tt0];%2分
    music_base1 = [music_base1;tt1];%4分
    music_base2 = [music_base2;tt2];%8分
end
music1 = [music_base1(12,:),music_base2(12,:),music_base2(13,:),music_base0(9,:)];
music2 = [music_base1(8,:),music_base2(8,:),music_base2(6,:),music_base0(9,:)];
music = [music1,music2];
music = music/2;
plot(music);
sound(music);