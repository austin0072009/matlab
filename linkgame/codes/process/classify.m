function class = classify(pair,edge)
[m,n] = size(pair);
class = zeros(1,m);
count = 1;
number = 0;
for i=1:m
    for j=1:n
        if pair(i,j)>edge
            number = number +1;
            if(class(i)==class(j))
                if(class(i)>0)
                    continue
                else
                    class(i) = count;
                    class(j) = count;
                    count = count+1;
                end
            else
                if(class(i)*class(j)>0)
                    if(class(i)<class(j))
                       ppos = find(class == class(j));
                       class(ppos) = class(i);
                       
                    else
                       ppos = find(class == class(i));
                       class(ppos) = class(j);
                    end
                else
                   if(class(i)>0)
                       class(j) = class(i);
                   else
                       class(i) = class(j);
                   end
                end
            end
        end
    end
end
