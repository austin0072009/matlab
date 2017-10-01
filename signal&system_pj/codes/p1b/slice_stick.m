function all_audio = slice_stick (dic,len)
%初始化所有wav文件，随机找出一个放入正确集
file_list = dir(strcat(dic,'*.wav'));
l = length(file_list);
out_name = file_list(1).name;
out_file = audioread(strcat(dic,out_name));
delete (strcat(dic,out_name));
file_list = dir(strcat(dic,'*.wav'));
l = length(file_list);
rate = len; %length of the start/end
%选取相关最大值，放入正确集
while l>0
    len=length(out_file);
    start = out_file(1:rate);
    edge = out_file(len-rate+1:len);
    r_s = xcorr(start);
    m_s = max(r_s);
    r_e = xcorr(edge);
    m_e = max(r_e);
    tag = -1;
    max_f = 10;
    max_pos = 0;
    max_name = '';
    for x = 1:l 
        f_name = file_list(x).name;
        file = audioread(strcat(dic,f_name));
        rr_s = xcorr(start,file);
        rr_e = xcorr(edge,file);
        mm_s = max(rr_s);
        mm_e = max(rr_e);
        %归一化
        r1 = mm_s/m_s;
        r2 = mm_e/m_e;        
        m = min(abs(r1-1),abs(r2-1));%%%
        if m<max_f
            max_r1 = r1;
            max_r2 = r2;
            max_name=f_name;
            max_f=m;
            if(abs(r1-1)<abs(r2-1))
                tag = 1;
                max_pos = find(rr_s==mm_s);
            else
                tag = 0; 
                max_pos = find(rr_e==mm_e);
            end
        end    
    end
    if(max_f<0.2)%%%阈值限制
        tmp=audioread(strcat(dic,max_name));
        tmp_l=length(tmp);
        if(tag==1)
             out_file = [tmp(1:tmp_l-max_pos);out_file];
        else
            out_file = [out_file;tmp(tmp_l-max_pos+rate+1:tmp_l)];
        end
    end
    
    delete (strcat(dic,max_name));
    file_list = dir(strcat(dic,'*.wav'));
    l = length(file_list);
end
all_audio = out_file;