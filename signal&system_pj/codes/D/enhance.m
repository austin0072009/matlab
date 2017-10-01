function output=enhance(speech)
%读入语音文件%
%定义参数%
winsize=256;
n=0.04;
size=length(speech);
numofwin=floor(size/winsize);
ham=hamming(winsize)';
hamwin=zeros(1,size);
enhanced=zeros(1,size);
x=speech';

noisy=n* randn(1,winsize);
N=fft(noisy);
nmag=abs(N);

%分帧%
for q=1:2*numofwin-1
    frame=x(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2);
    hamwin(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)=...
        hamwin(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)+ham;
        y=fft(frame.* ham);
        mag=abs(y);
        phase=angle(y);
        %幅度谱减%
        for i=1:winsize
            if mag(i)- nmag(i)>0
                clean(i)=mag(i)- nmag(i);
            else
                clean(i)=0;
            end
        end
        %在频域中重新合成%
        spectral=clean.* exp(j* phase);
        %反傅里叶变换并重叠相加%
        enhanced(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)=...
        enhanced(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)+real(ifft(spectral));
    end
    %除去汉明窗引起的增益%
    for i=1:size
        if hamwin(i)==0
            enhanced(i)=0;
        else
            enhanced(i)=enhanced(i)/hamwin(i);
        end 
    end
    
    ave = mean(abs(enhanced));
    x_d = (abs(enhanced)>0.4*ave);
    enhanced = (enhanced).*x_d; 
    %计算增强前后信噪比%
    
%     SNR1=10* log10(var(speech')/var(noisy));
%     SNR2=10* log10(var(speech')/var(enhanced- speech'));
    
    %audiowrite(x,fs,nbits,'noisy.wav');
    %audiowrite('P1b/enhanced.wav',enhanced,8000);
    output=enhanced;
    %画波形%
%     figure(1);
%     subplot(3,1,1);plot(speech');
%     title('原始语音波形');
%     xlabel('样点数');ylabel('幅度');
%     axis([0,3.5* 10^4,-0.5,0.5]);
%     subplot(3,1,2);plot(x);
%     title('加噪语音波形');
%     xlabel('样点数');ylabel('幅度');
%    axis([0,3.5* 10^4,-0.5,0.5]);
%     subplot(3,1,3);plot(enhanced);
%     title('语音增强波形');
%     xlabel('样点数');ylabel('幅度');
%     axis([0,3.5* 10^4,-0.5,0.5]);
end
