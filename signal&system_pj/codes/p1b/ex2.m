clear all;close all;clc;

file_path='P1b/';
out_path = 'P1b/out/';
mkdir(out_path);
file_list = dir('P1b/*.wav');
len = length(file_list);
for counter=1:len %%%%
    tp = file_list(counter).name;
    [y,fs] = audioread(strcat(file_path,tp));
    %ffs = 2200;
    %fp = 2500;
    %middle = ll_filter(y,ffs,fp);
    %index = 0.6;
    %xxd = wavelettt(middle,index);
    xxd = enhance(y);
    audiowrite(strcat(out_path,tp),xxd,8000);
    %clear sound;
end
out = slice_stick(out_path,24000);
audiowrite('P1b.wav',out,8000);
