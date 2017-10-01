close all;
clear all;
clc;
load q2_7_2.mat;
[m,n] = size(g_pic);
s = m*n;
pair = zeros(s,s);
addr = 'colorcapture/';
for i = 1:s
    im1 = double(g_pic{i});
    im11 = im1(:,:,1);
    im12 = im1(:,:,2);
    im13 = im1(:,:,3);
    
    x11 = mean([max(max(xcorr2(im11))),max(max(xcorr2(im12))),max(max(xcorr2(im13)))]);
    for j = i+1:s
        im2 = double(g_pic{j});
        im21 = im2(:,:,1);
        im22 = im2(:,:,2);
        im23 = im2(:,:,3);
        
        x22 = mean([max(max(xcorr2(im21))),max(max(xcorr2(im22))),max(max(xcorr2(im23)))]);
        x12 = mean([max(max(xcorr2(im11,im21))),max(max(xcorr2(im12,im22))),max(max(xcorr2(im13,im23)))]);
        rate = x12/sqrt(x11*x22);
        %if rate>max_pair
        %    max_pair = rate;
        %    name_list = [i,j,name_list];
        %end
        pair(i,j) = rate;
    end
end

figure;
tmp = pair;
for i = 1:10
    subplot(5,6,3*i-2);
    mm = max(max(tmp));
    [m,n] = find(tmp == mm);
    im1 = imread([addr,num2str(m),'.jpg']);
    im2 = imread([addr,num2str(n),'.jpg']);
    imshow(im1);
    title([num2str(m),' and ',num2str(n)]);
    subplot(5,6,3*i-1);
    imshow(im2);
    title(['ratio: ',num2str(mm)]);
    tmp(m,n) = 0;
end

save q2_7_3.mat;
