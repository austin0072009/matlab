close all;
clear all;
clc;

image_name = 'picture1.jpg';
data = imread(image_name);

data_r = data(:,:,1);
data_g = data(:,:,2);
data_b = data(:,:,3);
bw_rate = 0.45;
bwr = double(~im2bw(data_r,bw_rate));
bwg = double(~im2bw(data_g,bw_rate));
bwb = double(~im2bw(data_b,bw_rate));

data_bw = bwr+bwg+bwb;
data_bw = data_bw>1;

data_gt = gaotong(rgb2gray(data),30);
data_gt = data_gt-mean(mean(data_gt));

imshow(data_bw,[]);

line = mean(data_bw,1);
colomn = mean(data_bw,2);
subplot(2,1,1);
plot(line);
subplot(2,1,2);
plot(colomn);
[m,n] = size(data_bw);
%[~,p_l] = findpeaks(-line,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
[~,p_l] = findpeaks(-line,'MinPeakProminence',0.1,'MinPeakDistance',n/20,'Npeaks',13);
%[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.1,'MinPeakDistance',m/11,'Npeaks',8);
dl = diff(p_l);
dc = diff(p_c);
%dl = dl(find(abs(dl-mean(dl))<10));
%dc = dc(find(abs(dc-mean(dc))<10));
wl = mean(dl);
wc = mean(dc);
ln = length(p_l)-1;
cn = length(p_c)-1;
ls = p_l(1);
cs = p_c(1);

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
        images = data_bw(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5);
        image_w = data_gt(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5);
        imshow(images);
        g_pic{tag} = image_w;
    end
end

s = 84;
pair = zeros(s,s);
for i = 1:s
    im1 = double(g_pic{i});
    x11 = max(max(xcorr2(im1)));
    for j = i+1:s
        im2 = double(g_pic{j});
        x22 = max(max(xcorr2(im2)));
        x12 = max(max(xcorr2(im1,im2)));
        rate = x12/sqrt(x11*x22);

        pair(i,j) = rate;
    end
end

tmp = pair;
[s1,s2] = size(pair);
pp = reshape(pair,1,s1*s2);
pp = pp(find(pp>0));
pp = sort(pp);
pp2 = [pp(2:length(pp)),pp(length(pp))];
pp3 = pp2-pp;
pos = find(pp3 == max(pp3));
tell = (pp(pos+1)+pp(pos))/2;


res_mtx = classify(pair,tell);
res_mtx = reshape(res_mtx,ln,cn);
res_mtx = res_mtx';

image_data = data;
start_r = cs;
start_l = ls;
width_r = wc;
width_l = wl;

origin = res_mtx;
steps = omg(origin);

figure;
imshow(image_data);

number = steps(1);
steps = steps(2:length(steps));

for i=1:number
    pause(0.25);
    x1 = steps(1);
    y1 = steps(2);
    x2 = steps(3);
    y2 = steps(4);
    steps = steps(5:length(steps));
    clean = 0.15;
    image_data(start_r+(x1-1)*width_r+1:start_r+x1*width_r,start_l+(y1-1)*width_l+1:start_l+y1*width_l,:)=clean*image_data(start_r+(x1-1)*width_r+1:start_r+x1*width_r,start_l+(y1-1)*width_l+1:start_l+y1*width_l,:);
    image_data(start_r+(x2-1)*width_r+1:start_r+x2*width_r,start_l+(y2-1)*width_l+1:start_l+y2*width_l,:)=clean*image_data(start_r+(x2-1)*width_r+1:start_r+x2*width_r,start_l+(y2-1)*width_l+1:start_l+y2*width_l,:);
    imshow(image_data);
    text(start_l+(y1-0.5)*width_l,start_r+(x1-0.5)*width_r,num2str(i),'horiz','center','color','red');
    text(start_l+(y2-0.5)*width_l,start_r+(x2-0.5)*width_r,num2str(i),'horiz','center','color','red');  
end
pause(0.25);
imshow(image_data);
