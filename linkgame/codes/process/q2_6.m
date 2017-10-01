close all;
clear all;
clc;

%载入索引矩阵和图片分割信息。
load q2_5.mat;

name = 'graycapture.jpg';
image_ori = imread(name);
image_data = image_ori;

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
%画出每步步骤。
for i=1:number
    pause;
    x1 = steps(1);
    y1 = steps(2);
    x2 = steps(3);
    y2 = steps(4);
    steps = steps(5:length(steps));
    image_data(start_r+(x1-1)*width_r+1:start_r+x1*width_r,start_l+(y1-1)*width_l+1:start_l+y1*width_l)=0;
    image_data(start_r+(x2-1)*width_r+1:start_r+x2*width_r,start_l+(y2-1)*width_l+1:start_l+y2*width_l)=0;
    imshow(image_data);
    text(start_l+(y1-0.5)*width_l,start_r+(x1-0.5)*width_r,num2str(i),'horiz','center','color','red');
    text(start_l+(y2-0.5)*width_l,start_r+(x2-0.5)*width_r,num2str(i),'horiz','center','color','red');  
end
pause(0.3);
imshow(image_data);