function [tag1,tag2,tag3,tag] = detect_tag4(y,w,mm)
%tag1: 回响标记(优先处理)  3<一重>,2<没有>,1<多重>.
%tag2: 幅度偏小标记(后置处理)==>2<没有>&1<有>
%tag3: 限幅标记(最后处理) ==>0
%tag = tag1*tag2*tag3
z = xcorr(y);
m1 = max(z);
m = find(z == max(z));
width = w;
tmp = z;
tmp(m-width:m+width-1)= 0 ;
m2 = max(tmp);
pos = find(tmp == max(tmp));
delay1 = abs(m-pos(1)) ;
d_1 = m-delay1;
d_2 = m+delay1;
tmp(d_1-width:d_1+width-1)= 0 ;
tmp(d_2-width:d_2+width-1)= 0 ;
m3 = max(tmp);

len1 = length(y);
ma = find(y == max(y));
len2 = length(ma);
if(m2/m1>0.2)
    if(m3/m1>0.18)
        tag1 = 1;
    else
        tag1 = 3;
    end
else
   tag1 = 2; 
end

if(max(y)>mm)
   tag2 = 2;
else
   tag2 = 1;
end

if(len2/len1 > 0.1)
    tag3 = 0;
else
    tag3 = 1;
end
tag = tag1*tag2*tag3;