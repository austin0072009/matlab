function [pat,rythm] = define_pat(freq,len)
rythm_name = ['F  ';'bG ';'G  ';'bA ';'A  ';'bB ';'B  ';'C  ';'bD ';'D  ';'bE ';'E  ';...
   'F+ ';'bG+';'G+ ';'bA+';'A+ ';'bB+';'B+ ';'C+ ';'bD+';'D+ ';'bE+';'E+ '];
stand = 174.61/2^(1/24);
index = 2^(1/12);
%存在漏洞
%成立的前提是这是一段简单的、正常的语音
%即不能有超过阈值的超高音或者超低音
pat = 'NaN';
rythm = 'NaN';
for i = 1:24    
    if(freq<stand*(index^i))
       rythm = rythm_name(i,:);
       break;
    end
end
%根据时间分为5种长度，同ex1_5模式
pat_name = ['0.5';'1.0';'1.5';'2.0';'3.0'];
pat_stand = 1000;
for i =1:5
   if(len < pat_stand + i*2000)
      pat = pat_name(i,:); 
      break;
   end
   if (i==5)
       pat = pat_name(5,:);
   end
end
