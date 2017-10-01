function output=enhance(speech)
%���������ļ�%
%�������%
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

%��֡%
for q=1:2*numofwin-1
    frame=x(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2);
    hamwin(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)=...
        hamwin(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)+ham;
        y=fft(frame.* ham);
        mag=abs(y);
        phase=angle(y);
        %�����׼�%
        for i=1:winsize
            if mag(i)- nmag(i)>0
                clean(i)=mag(i)- nmag(i);
            else
                clean(i)=0;
            end
        end
        %��Ƶ�������ºϳ�%
        spectral=clean.* exp(j* phase);
        %������Ҷ�任���ص����%
        enhanced(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)=...
        enhanced(1+(q-1)* winsize/2:winsize+(q-1)* winsize/2)+real(ifft(spectral));
    end
    %��ȥ���������������%
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
    %������ǿǰ�������%
    
%     SNR1=10* log10(var(speech')/var(noisy));
%     SNR2=10* log10(var(speech')/var(enhanced- speech'));
    
    %audiowrite(x,fs,nbits,'noisy.wav');
    %audiowrite('P1b/enhanced.wav',enhanced,8000);
    output=enhanced;
    %������%
%     figure(1);
%     subplot(3,1,1);plot(speech');
%     title('ԭʼ��������');
%     xlabel('������');ylabel('����');
%     axis([0,3.5* 10^4,-0.5,0.5]);
%     subplot(3,1,2);plot(x);
%     title('������������');
%     xlabel('������');ylabel('����');
%    axis([0,3.5* 10^4,-0.5,0.5]);
%     subplot(3,1,3);plot(enhanced);
%     title('������ǿ����');
%     xlabel('������');ylabel('����');
%     axis([0,3.5* 10^4,-0.5,0.5]);
end
