clear all;close all;clc;
file_path='D/';
out_path = strcat(file_path,'out/');
mkdir(out_path);
file_list = dir(strcat(file_path,'/*.wav'));
len = length(file_list);
%‘§¥¶¿Ì
for i=1:len
    na = file_list(i).name;
    y = audioread(strcat(file_path,na));
    width = 100;
    [file_list(i).tag1,file_list(i).tag2,file_list(i).tag3,file_list(i).tag] = detect_tag4(y,width,0.1);
    file_list(i).use = 0;
end
%»•‘Î
for i = 1:len
    na = file_list(i).name;
    [y,fs]=audioread(strcat(file_path,na));
    if(file_list(i).tag1 ~= 2)
        middle = echo_audio_d(y,100);
    else
        middle = y;
    end
    if(file_list(i).tag3 == 1)
        out = ll_filter(middle,2200,2500);
        xd = wavelettt(out,0.6);
    else
        xd = enhance(middle);
    end
    audiowrite(strcat(out_path,na),xd,8000);
end
%≈≈–Ú
rate = 24000;
out = select_d(out_path,file_list,rate);
audiowrite('D.wav',out,8000);
