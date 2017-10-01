function tag = detect_tag(y,w)
z = xcorr(y);
m1 = max(z);
m = find(z == max(z));
width = w;
tmp = z;
tmp(m-width:m+width-1)= 0 ;
m2 = max(tmp);
len1 = length(y);
m = find(y == max(y));
len2 = length(m);
if(m2/m1>0.15)
   tag = 2; 
elseif(len2/len1 > 0.1)
    tag = 0;
else
    tag = 1;
end