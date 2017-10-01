close all;
clear all;
clc;
image_name = 'colorcapture.jpg';
data = imread(image_name);
data_r = data(:,:,1);
data_g = data(:,:,2);
data_b = data(:,:,3);
bw_rate = 0.85;
bwr = double(~im2bw(data_r,bw_rate));
bwg = double(~im2bw(data_g,bw_rate));
bwb = double(~im2bw(data_b,bw_rate));

data_bw = bwr+bwg+bwb;
data_bw = data_bw>1;

for j =1:3
    data_gt(:,:,j) = gaotong(data(:,:,j),30);
    data_gt(:,:,j) = data_gt(:,:,1)-mean(mean(data_gt(:,:,j)));
end

imshow(data_bw,[]);

line = mean(data_bw,1);
colomn = mean(data_bw,2);
subplot(2,1,1);
plot(line);
subplot(2,1,2);
plot(colomn);
[m,n] = size(data_bw);
%[~,p_l] = findpeaks(-line,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
[~,p_l] = findpeaks(-line,'MinPeakProminence',0.05,'MinPeakDistance',n/20,'Npeaks',13);
%[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.1,'MinPeakDistance',m/11,'Npeaks',8);
dl = diff(p_l);
dc = diff(p_c);
dl = dl(find(abs(dl-mean(dl))<10));
dc = dc(find(abs(dc-mean(dc))<10));
wl = mean(dl);
wc = mean(dc);
ln = length(p_l)-1;
cn = length(p_c)-1;
ls = mean(p_l)-6*wl;
cs = mean(p_c)-3.5*wc;

s1 = 10;
s2 = 25;
[ll1,ll2] = size(data_bw);
g_pic = cell(1,cn*ln);
figure;
for i = 1:cn
    for j =1:ln
        tag = (i-1)*12+j;
        subplot(7,12,tag);
        
        p1 = round(max(1,cs+(i-1)*wc+1-s1));
        p2 = round(min(ll1,cs+i*wc+s1));
        p3 = round(max(1,ls+(j-1)*wl+1-s1));
        p4 = round(min(ll2,ls+j*wl+s1));
        image = data_bw(p1:p2,p3:p4);
        imshow(image,[]);
        
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
        %imshow(image);
        images = data(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5,:);
        image_w = data_gt(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5,:);
        imshow(images);
        g_pic{tag} = image_w;
    end
end
save q2_7_2.mat;