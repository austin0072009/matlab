function tmp = ll_filter(y,FS,FP)
fp=FS;                                 %ͨ����ֹƵ��  
fs=FP;                                 %�����ֹƵ��  
At=100;                                  %����˥��ϵ��(dB)  
wave=1;                                  %�����Ʋ�ϵ��(dB)  
mval=[1 0];                              %�߽紦�ķ�ֵ  
fedge=[fp fs];  
derta1=1-10^(-wave/20);                  %��1�ļ���  
derta2=10^(-At/20);                      %��2�ļ���  
dev=[derta1 derta2];                     %����������1���2  
fs=8000;                                 %FIR����Ƶ��  
%��������  
[N,fpts,mag,wt]=remezord(fedge,mval,dev,fs);  
%�����Ƚ����㷨�������FIR�˲���  
b=remez(N,fpts,mag,wt);
%FIR�˲�����λ������Ӧ
tmp = filter(b,1,y); 