close all;
clear all;
clc;

true_mtx = [1,2,1,3,4,5,6,7,8,9,9,10;
            11,3,10,20,10,12,8,13,9,14,15,8;
            16,17,9,14,20,11,6,20,2,6,16,11;
            20,17,8,20,2,8,6,3,6,11,20,16;
            15,2,13,4,17,9,17,9,12,7,20,3;
            16,8,18,16,1,18,16,7,4,12,7,8;
            12,8,6,9,4,5,10,1,12,9,20,12];
true_mtx = true_mtx';

load q2_7_3.mat;
tmp = pair;
figure;
addr = 'colorcapture/';

for i = 1:10
    subplot(5,6,3*i-2);
    while 1
        mm = max(max(tmp));
        [p1,p2] = find(tmp == mm);
        tmp(p1,p2) = 0;
        if true_mtx(p1)==true_mtx(p2)
            continue;
        end
        im1 = imread([addr,num2str(p1),'.jpg']);
        im2 = imread([addr,num2str(p2),'.jpg']);
        imshow(im1);
        title([num2str(p1),' and ',num2str(p2)]);
        subplot(5,6,3*i-1);
        imshow(im2);
        title(['ratio: ',num2str(mm)]);
        break;
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

tmp = (tmp<tell).*tmp;

for i = 1:10
    subplot(5,6,3*i-2);
    mm = max(max(tmp));
    [p1,p2] = find(tmp == mm);
    im1 = imread([addr,num2str(p1),'.jpg']);
    im2 = imread([addr,num2str(p2),'.jpg']);
    imshow(im1);
    title([num2str(p1),' and ',num2str(p2)]);
    subplot(5,6,3*i-1);
    imshow(im2);
    title(['ratio: ',num2str(mm)]);
    tmp(p1,p2) = 0;
end

save q2_7_4.mat;