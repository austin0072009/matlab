close all;
clear all;
clc;
load q2_7_4.mat;
%标定
true_mtx=[1,2,1,3,4,5,6,7,8,9,9,10;
    11,3,10,12,10,13,8,14,9,15,16,8;
    17,18,9,15,12,11,6,12,2,6,17,11;
    12,18,8,12,2,8,6,3,6,11,12,17;
    16,2,14,4,18,9,18,9,13,7,12,3;
    17,8,19,17,1,19,17,7,4,13,7,8;
    13,8,6,9,4,5,10,1,13,9,12,13];
%判断正确率
res_mtx = classify(pair,tell);
res_mtx = reshape(res_mtx,ln,cn);
res_mtx = res_mtx';
detect = (res_mtx == true_mtx);
count = find(detect == 1);
disp(['Accuracy Rate: ',num2str(length(count)),'/84']);
save q2_7_5.mat;


