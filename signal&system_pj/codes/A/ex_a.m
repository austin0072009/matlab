clear all; clc; close all;

file_path='A/';
out = slice_stick(file_path,24000);
audiowrite('A.wav',out,8000);
