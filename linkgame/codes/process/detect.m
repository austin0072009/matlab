function bool = detect(mtx, x1, y1, x2, y2)
    % ========================== 参数说明 ==========================
    
    % 输入参数中，mtx为图像块的矩阵，类似这样的格式：
    % [ 1 2 3;
    %   0 2 1;
    %   3 0 0 ]
    % 相同的数字代表相同的图案，0代表此处没有块。
    % 可以用[m, n] = size(mtx)获取行数和列数。
    % (x1, y1)与（x2, y2）为需判断的两块的下标，即判断mtx(x1, y1)与mtx(x2, y2)
    % 是否可以消去。
    
    % 注意mtx矩阵与游戏区域的图像不是位置对应关系。下标(x1, y1)在连连看界面中
    % 代表的是以左下角为原点建立坐标系，x轴方向第x1个，y轴方向第y1个
    
    % 输出参数bool = 1表示可以消去，bool = 0表示不能消去。
    
    %% 在下面添加你的代码O(∩_∩)O
    bool = 0;
    if(mtx(x1,y1)==mtx(x2,y2))
        bool = detect1(mtx, x1, y1, x2, y2);
        if(bool == 0)
            bool = detect2(mtx, x1, y1, x2, y2);
        end
        if(bool == 0)
            bool = detect3(mtx, x1, y1, x2, y2);
        end
    end
end
function b1 = detect1(mtx, x1, y1, x2, y2)
    b1 = 0;
    if (x1==x2)
        if(y1>y2)
            tmp = y2;
            y2 = y1;
            y1 = tmp;
        end
        d = mtx(x1,y1+1:y2-1);
        if (d*d'==0)
            b1 = 1;
        end
    else
    if(y1==y2)
            if(x1>x2)
                tmp = x2;
                x2 = x1;
                x1 = tmp;
            end
            d = mtx(x1+1:x2-1,y1);
            if(d'*d==0)
                b1 = 1;
            end
    end
    end
end
function b2 = detect2(mtx, x1, y1, x2, y2)
    b2 = 0;
    imp1 = mtx(x2,y1);
    imp2 = mtx(x1,y2);
    if(imp1^2*imp2^2==0)
        if(x1>x2)
            tmpx = x1;
            x1 = x2;
            x2 = tmpx;
            tmpy = y1;
            y1 = y2;
            y2 = tmpy;
        end
        mi = min(y1,y2);
        ma = max(y1,y2);
        l1 = mtx(x1+1:x2-1,y1);
        l2 = mtx(x1+1:x2-1,y2);
        r1 = mtx(x1,mi+1:ma-1);
        r2 = mtx(x2,mi+1:ma-1);
        if(l1'*l1+r2*r2'+mtx(x2,y1)^2==0 | l2'*l2+r1*r1'+mtx(x1,y2)^2==0)
            b2 = 1;
        end
    end
end

function b3 = detect3(mtx, x1, y1, x2, y2)
    [m, n] = size(mtx);
    row = zeros(m,1);
    line = zeros(1,n+2);
    mtx = [row,mtx,row];
    mtx = [line;mtx;line];
    x1 = x1+1;
    y1 = y1+1;
    x2 = x2+1;
    y2 = y2+1;
    b3 = 0;
    for count = 1:m+2
        if(count == x1 | count == x2)
            continue
        end
        if(mtx(count,y1)==0 && detect2(mtx,count,y1,x2,y2) && detect1(mtx,count,y1,x1,y1))
            b3 = 1;
            break;
        end
    end
    if(b3==0)
        for count = 1:n+2
            if(count == y1 | count ==y2)
                continue;
            end
            if(mtx(x1,count)==0 && detect2(mtx,x1,count,x2,y2)&&detect1(mtx,x1,count,x1,y1))
                b3 = 1;
                break;
            end
        end
    end
end


 
    
