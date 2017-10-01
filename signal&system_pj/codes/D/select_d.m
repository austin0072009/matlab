function out = select_d(dirt,file_list,R)
l = length(file_list);
for i = 1:l
   if(file_list(i).tag==6)
       file_name = file_list(i).name;
       out_file = audioread(strcat(dirt,file_name));
       file_list(i).use =1;
       break;
   else
       continue;
   end
end
rate = R; %length of the start/end
rotate = 1;

while rotate>0
    len=length(out_file);
    start = out_file(1:rate);
    edge = out_file(len-rate+1:len);
    r_s = xcorr(start);
    m_s = max(r_s);
    r_e = xcorr(edge);
    m_e = max(r_e);
    max_f = 10;
    max_pos = 0;
    max_name ='';
    max_use = 0;
    ave_out = mean(abs(out_file));
    tell = -1;
    first = 1;%”≈œ»º∂
    for x = 1:l
       if(file_list(x).use==1)
           continue
       else
           f_name = file_list(x).name;
           file = audioread(strcat(dirt,f_name));
           ave_t = mean(abs(file));
           file = ave_out/ave_t*file;
           rr_s = xcorr(start,file);
           rr_e = xcorr(edge,file);
           mm_s = max(rr_s);
           mm_e = max(rr_e);
           r1 = mm_s/m_s;
           r2 = mm_e/m_e;        
           m = min(abs(r1-1),abs(r2-1));
           if m<max_f
               max_name=f_name;
               max_f=m;
               max_use = x;
               first = file_list(x).tag;
               if(abs(r1-1)<abs(r2-1))
                   tell = 1;
                   max_pos = find(rr_s==mm_s);
               else
                   tell = 0;
                   max_pos = find(rr_e==mm_e);
               end
           end
       end
    end
    if(max_f<0.3)
        tmp=audioread(strcat(dirt,max_name));
        ave_out = mean(abs(out_file));
        ave_t = mean(abs(tmp));
        tmp = ave_out/ave_t*tmp;
        tmp_l=length(tmp);
        file_list(max_use).use=1;
        if(tell == 1)
            size = max_pos;
           if(first>3)
               out_file = [tmp;out_file(size+1:len)];
           elseif(first == 2)
               if(file_list(max_use).tag2==2)
                   out_file = [tmp(1:tmp_l-size);out_file];
               else
                   tmp = mean(abs(out_file))/mean(abs(tmp))*tmp;
                   out_file = [tmp(1:tmp_l-size);out_file];
               end
           else
               tmp = mean(abs(out_file))/mean(abs(tmp))*tmp;
               out_file = [tmp(1:tmp_l-size);out_file];
           end      
        else
            size = tmp_l-max_pos+rate;
            if(first>3)
                out_file = [out_file(1:len-size);tmp];
            elseif(first==2)
                if(file_list(max_use).tag2==2)
                    out_file = [out_file;tmp(size+1:tmp_l)];
                else
                    tmp = mean(abs(out_file))/mean(abs(tmp))*tmp;
                    out_file = [out_file;tmp(size+1:tmp_l)];
                end
            else
                tmp = mean(abs(out_file))/mean(abs(tmp))*tmp;
                out_file = [out_file;tmp(size+1:tmp_l)];
            end
            
        end
    else
        rotate = 0;
    end
end
%rmdir(dirt);
out = out_file;
