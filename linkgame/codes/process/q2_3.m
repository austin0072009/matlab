close all;
clear all;
clc;
%��ͨͼ��ָ����洢��2.2����ļ��С�
load q2_2.mat;
[m,n] = size(g_pic);
s = m*n;
pair = zeros(s,s);
addr = 'capture/';
%�õ���ؾ���
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

%�ҵ��������ߵ�10��ͼ��
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

save q2_3.mat;