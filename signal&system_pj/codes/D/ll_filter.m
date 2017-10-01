function tmp = ll_filter(y,FS,FP)
fp=FS;                                 %通带截止频率  
fs=FP;                                 %阻带截止频率  
At=100;                                  %带外衰减系数(dB)  
wave=1;                                  %带内纹波系数(dB)  
mval=[1 0];                              %边界处的幅值  
fedge=[fp fs];  
derta1=1-10^(-wave/20);                  %δ1的计算  
derta2=10^(-At/20);                      %δ2的计算  
dev=[derta1 derta2];                     %基本参数δ1与δ2  
fs=8000;                                 %FIR采样频率  
%参数计算  
[N,fpts,mag,wt]=remezord(fedge,mval,dev,fs);  
%雷米兹交替算法设计最优FIR滤波器  
b=remez(N,fpts,mag,wt);
%FIR滤波器单位脉冲响应
tmp = filter(b,1,y); 