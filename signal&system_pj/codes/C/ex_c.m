clear all;close all;clc;

file_path='C/';
out_path = strcat(file_path,'out/');
mkdir(out_path);
file_list = dir(strcat(file_path,'/*.wav'));
len = length(file_list);

%预处理
for i=1:len
    na = file_list(i).name;
    y = audioread(strcat(file_path,na));
    width = 100;
    file_list(i).tag = detect_tag(y,width);
    file_list(i).use = 0;
end

%去噪处理
for i = 1:len
   tp = file_list(i).name;
   [y,fs] = audioread(strcat(file_path,tp));
   tagg = file_list(i).tag;
   if(tagg == 2)
      xxd = echo_audio(y,100); 
   elseif(tagg ==1)
       xxd = enhance(y);
   else
       % not sure which fuction to use.
       t_m = ll_filter(y,2200,2500);
       xxd = wavelettt(t_m,0.6);
   end
    audiowrite(strcat(out_path,tp),xxd,8000);
end
%排序

rate = 40000;
out = select_c(out_path,file_list,rate);
audiowrite('C.wav',out,8000);
