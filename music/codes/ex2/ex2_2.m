clear all;
close all;
clc;
load Guitar.mat;;
origin = realwave;
origin_l = length(origin);
middle = resample(origin,10,1);
middle_l = length(middle);
result = zeros(origin_l,1);
for i = 1:10
    result = result + middle((i-1)*origin_l+1:i*origin_l);
end
result = result/10;
result = resample(result,1,10);%压缩1／10
result = [result;result;result;result;result];
result = [result;result];
l1 = length(result);
l2 = origin_l;
result = resample(result,1000,round(1000*(l1/l2)));%定长
%noise = realwave - result
%F1 = fft(realwave);
%F2 = fft(noise);
%F = F1-F2;
%res_final = abs(ifft(F));

similarity = max(xcorr(result,wave2proc))/max(xcorr(wave2proc))；%计算相似度

figure;
subplot(3,1,1);
plot(realwave);
title('realwave');
subplot(3,1,2);
plot(wave2proc);
title('wave2proc');
subplot(3,1,3);
plot(result);
title('result');
%subplot(3,1,3);
%plot(res_final);
%title('denoise');
