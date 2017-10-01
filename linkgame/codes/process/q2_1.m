clear all;
close all;
clc;
name = 'graygroundtruth.jpg';
%image_name = 'graycapture.jpg';

%二值化
data = imread(name);
origin_data = data;
data = double(~im2bw(data,0.85));

imshow(data,[])

%图片分割
line = sum(data,1);
colomn = sum(data,2);
subplot(2,1,1);
plot(line);
subplot(2,1,2);
plot(colomn);
[m,n] = size(data);

[~,p_l] = findpeaks(-line,'MinPeakDistance',n/20);
[~,p_c] = findpeaks(-colomn,'MinPeakDistance',m/11);

ls = p_l(1);
cs = p_c(1);
dl = diff(p_l);
dc = diff(p_c);
dl = dl(find(abs(dl-mean(dl))<10));
dc = dc(find(abs(dc-mean(dc))<10));
wl = mean(dl);
wc = mean(dc);
ln = length(p_l)-1;
cn = length(p_c)-1;


figure;

%图片去边缘和显示
s1 = 10;
s2 = 25;
[ll1,ll2] = size(data);
for i = 1:cn
    for j =1:ln
        tag = (i-1)*12+j;
        subplot(7,12,tag);
        
        p1 = round(max(1,cs+(i-1)*wc+1-s1));
        p2 = round(min(ll1,cs+i*wc+s1));
        p3 = round(max(1,ls+(j-1)*wl+1-s1));
        p4 = round(min(ll2,ls+j*wl+s1));
        image = data(p1:p2,p3:p4);
        
        ave1 = sum(image,2);
        ave2 = sum(image,1);
        l1 = length(ave1);
        l2 = length(ave2);
        
        d1 = ave1(1:s2);
        d2 = ave1(l1-s2+1:l1);
        d3 = ave2(1:s2);
        d4 = ave2(l2-s2+1:l2);

        pos1 = find(d1 == max(d1));
        pos1 = pos1(1);
        pos2 = find(d2 == max(d2));
        pos2 = pos2(1);
        pos3 = find(d3 == max(d3));
        pos3 = pos3(1);
        pos4 = find(d4 == max(d4));
        pos4 = pos4(1);
        imshow(image);
        %image = origin_data(cs+(i-1)*wc+1:cs+i*wc,ls+(j-1)*wl+1:ls+j*wl);
        images = origin_data(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5);
        imshow(images);
    end
end


