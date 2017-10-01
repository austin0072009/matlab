clear all; clc; close all;

file_path='P1a/';
out = slice_stick(file_path,24000);
audiowrite('P1a.wav',out,8000);
