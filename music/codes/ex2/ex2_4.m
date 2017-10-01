clear all;
close all;
clc;
element = audioread('fmt.wav');
rate = 600; %²ÉÑùÂÊ
treat = element;
l = length(treat);
i = 1;
pos = [];
pos_1 = 0;
pos_2 = 0;
m_1 = 0;
m_2 = 0;
while i<l-rate
    pos_1 = pos_2;
    m_1 = m_2;
    tmp = treat(i:i+rate-1);
    pos_2 = find(tmp==max(tmp));
    m_2 = tmp(pos_2);
    pos_2 = pos_2 + i-1;
    if(m_2>m_1)
        pos_l = length(pos);
        pos = [pos;pos_2];
    end
    i = i+rate;
end
len = length(pos);
res1 = [];
for k = 1:len
    if (pos(k)<1500)
        continue;
    end
    if(pos(k)+1500>l)
        break;
    end
    tmp = treat(pos(k)-1500:pos(k)+1500);
    if(find(tmp == max(tmp))==1501)
        res1 = [res1,pos(k)];
    end
end
res2 = [res1(1:11),res1(13),res1(15:31)];

subplot(3,1,1);
plot(element);
hold on;
plot([pos(:) pos(:)],[-0.6 0.6],'red');
title('step1');
subplot(3,1,2);
plot(element);
hold on;
plot([res1(:) res1(:)],[-0.6 0.6],'red');
title('step2');

subplot(3,1,3);
plot(element);
hold on;
plot([res2(:) res2(:)],[-0.6 0.6],'red');
title('step3');

res2_l = length(res2);
tmp = treat(1:res2(1));
tmp1 = find(tmp>0.01);
tmp = tmp(tmp1(1)+100:tmp1(1)+300);
len = length(tmp(tmp1(1)+1:length(tmp)));
transfer_middle = {};
transfer = [];
[freq,data_tmp] = find_res(tmp,8000);
[pat,rythm] = define_pat(freq,len);
display = ['(1)','  ',pat,'  ',rythm,' ',num2str(freq)];
transfer_middle = {num2str(1),pat,rythm,num2str(freq)};
transfer = [transfer_middle];
disp(display);
data = [data_tmp];
data_tmp;
for i = 1:res2_l-1
    tmp = treat(res2(i):res2(i)+300);
    [freq,data_tmp] = find_res(tmp,8000);
    data = [data;data_tmp];
    len = res2(i+1)-res2(i);
    [pat,rythm] = define_pat(freq,len);
    display = ['(',num2str(i+1),')','  ',pat,'  ',rythm,' ',num2str(freq)];
    transfer_middle = {num2str(i+1),pat,rythm,num2str(freq)};
    transfer = [transfer;transfer_middle];
    disp(display);
end
tmp = treat(res2(res2_l):res2(res2_l)+300);
[freq,data_tmp] = find_res(tmp,8000);
data = [data;data_tmp];
len = l-res2(i);
[pat,rythm] = define_pat(freq,len);
display = ['(',num2str(res2_l+1),')','  ',pat,'  ',rythm,' ',num2str(freq)];
transfer_middle = {num2str(res2_l+1),pat,rythm,num2str(freq)};
transfer = [transfer;transfer_middle];
disp(display);