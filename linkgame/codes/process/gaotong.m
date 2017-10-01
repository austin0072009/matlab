function res = gaotong(input,freq)
tmp = fft2(input);
tmp2 = fftshift(tmp);
[m,n] = size(tmp2);
for i = 1:m
    for j = 1:n
        s = sqrt((i-floor(m/2))^2+(j-floor(n/2))^2);
        %if s<=freq
        %    tmp2(i,j) = 0*tmp2(i,j);
        %else
        %    tmp2(i,j) = 1*tmp2(i,j);
        %end
        if s==0
            tmp2(i,j) = 0;
        else
            h = 1/(1+0.414*(freq/s)^4);
            tmp2(i,j) = h*tmp2(i,j);
        end
    end
end
res = ifftshift(tmp2);
res = uint8(real(ifft2(res)));
