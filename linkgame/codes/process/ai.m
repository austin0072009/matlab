function step = ai(realcapture)   
    % --------- 输入参数说明  -------- %
    
    %   realcapture是摄像头捕获的图像（矩阵），具体格式是rgb、ycbcr或灰度
    %   由你的user_camera函数的返回值（也叫realcapture）决定
 
    % --------- 输出参数说明  -------- %
    
    %   计算出的操作放在step数组里,格式如下：
    %   若当前已无法找到可以相连的块，则step = -1
    %   否则step里有四个数，代表把(step(1), step(2))与（step(3), step(4)）位置的块相连
    %   示例： step = [1 1 1 2];  
    %   表示当前步骤为把下标为(1,1)和(1,2)的块相连
    
    %   注意下标(a, b)在游戏图像中对应的是以左下角为原点建立直角坐标系，
    %   x轴方向第a个，y轴方向第b个的块
    
    %% --------------  请在下面加入你的代码 ------------ %
    
    data = realcapture;
    
    persistent steps;
    persistent number;
    persistent count;
    
    if(isempty(steps))
        data_r = data(:,:,1);
        data_g = data(:,:,2);
        data_b = data(:,:,3);
        bw_rate = 0.45;
        bwr = double(~im2bw(data_r,bw_rate));
        bwg = double(~im2bw(data_g,bw_rate));
        bwb = double(~im2bw(data_b,bw_rate));

        data_bw = bwr+bwg+bwb;
        data_bw = data_bw>1;

        for j =1:3
            data_gt(:,:,j) = gaotong(data(:,:,j),30);
            data_gt(:,:,j) = data_gt(:,:,1)-mean(mean(data_gt(:,:,j)));
        end

        imshow(data_bw,[]);

        line = mean(data_bw,1);
        colomn = mean(data_bw,2);
        %subplot(2,1,1);
        %plot(line);
        %subplot(2,1,2);
        %plot(colomn);
        %[m,n] = size(data_bw);
        %[~,p_l] = findpeaks(-line,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
        %[~,p_l] = findpeaks(-line,'MinPeakProminence',0.1,'MinPeakDistance',n/20,'Npeaks',13);
        %[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.3,'MaxPeakWidth',10,'MinPeakDistance',30);
        %[~,p_c] = findpeaks(-colomn,'MinPeakProminence',0.1,'MinPeakDistance',m/11,'Npeaks',8);
        dl = diff(p_l);
        dc = diff(p_c);
        wl = mean(dl);
        wc = mean(dc);
        ln = length(p_l)-1;
        cn = length(p_c)-1;
        ls = p_l(1);
        cs = p_c(1);

        s1 = 10;
        s2 = 25;
        [ll1,ll2] = size(data_bw);
        g_pic = cell(1,cn*ln);

        for i = 1:cn
            for j =1:ln
                tag = (i-1)*12+j;
                subplot(7,12,tag);

                p1 = round(max(1,cs+(i-1)*wc+1-s1));
                p2 = round(min(ll1,cs+i*wc+s1));
                p3 = round(max(1,ls+(j-1)*wl+1-s1));
                p4 = round(min(ll2,ls+j*wl+s1));
                image = data_bw(p1:p2,p3:p4);
                imshow(image,[]);

                ave1 = sum(image,2);
                ave2 = sum(image,1);
                l1 = length(ave1);
                l2 = length(ave2);

                d1 = ave1(1:s2);
                d2 = ave1(l1-s2+1:l1);
                d3 = ave2(1:s2);
                d4 = ave2(l2-s2+1:l2);

                pos1 = find(d1 == max(d1));
                pos1 = pos1(1);
                pos2 = find(d2 == max(d2));
                pos2 = pos2(1);
                pos3 = find(d3 == max(d3));
                pos3 = pos3(1);
                pos4 = find(d4 == max(d4));
                pos4 = pos4(1);
                image_w = data_gt(p1+pos1+5:p2+pos2-s2-5,p3+pos3+5:p4+pos4-s2-5,:);
                g_pic{tag} = image_w;
            end
        end

        s = 84;
        pair = zeros(s,s);
        for i = 1:s
            im1 = double(g_pic{i});
            im11 = im1(:,:,1);
            im12 = im1(:,:,2);
            im13 = im1(:,:,3);

            x11 = mean([max(max(xcorr2(im11))),max(max(xcorr2(im12))),max(max(xcorr2(im13)))]);
            for j = i+1:s
                im2 = double(g_pic{j});
                im21 = im2(:,:,1);
                im22 = im2(:,:,2);
                im23 = im2(:,:,3);

                x22 = mean([max(max(xcorr2(im21))),max(max(xcorr2(im22))),max(max(xcorr2(im23)))]);
                x12 = mean([max(max(xcorr2(im11,im21))),max(max(xcorr2(im12,im22))),max(max(xcorr2(im13,im23)))]);
                rate = x12/sqrt(x11*x22);

                pair(i,j) = rate;
            end
        end

        tmp = pair;
        [s1,s2] = size(pair);
        pp = reshape(pair,1,s1*s2);
        pp = pp(find(pp>0));
        pp = sort(pp);
        pp2 = [pp(2:length(pp)),pp(length(pp))];
        pp3 = pp2-pp;
        pos = find(pp3 == max(pp3));
        tell = (pp(pos+1)+pp(pos))/2;


        res_mtx = classify(pair,tell);
        res_mtx = reshape(res_mtx,ln,cn);
        res_mtx = res_mtx';

        origin = res_mtx;
        steps = omg(origin);
        number = steps(1);
        steps = steps(2:length(steps));
        count = 0;
    end
    
    if(count < number) 
        begin = 4*count+1;
        step = steps(begin:begin+3);
        count = count+1;
    else
        step = -1;
    end
    
end
