function [k,m,new_yy] = Statistic_km( n,m,c)

%s=floor(45/n);
s=7;
column=n*(s+1);
row=column+1;
%%
for i=1:50
    c1=c(1,1+(i-1)*n : (i+2*s)*n*n);
    
    for j=1:row%第1行到第row行
        y{i}(j,:)=c1(1,1+(j-1)*n:(j+s)*n);
    end
    
    if i==1
        Y=y{1};
    else
        Y=[Y,y{i}];
    end
    
end
%%
for i=1:50
    new_y{i}=gfRref2(y{i});
    %r(i,1)=gfrank(y{i},2);
    r(i,1)=rank(new_y{i},2);
    r(i,2)=i;
end
new_r=sortrows(r,1);
new_r=new_r';
%%
%提取对角线元素
M=50;
length_o=column;
O=zeros(M,length_o);
for i=1:M
    temp_diag_elements=diag(new_y{new_r(2,i)});
    O(i,:)=temp_diag_elements;
end
%%
%求和归一化
final_O=sum(O);
O_2=floor(mapminmax(final_O,0,1));

%%
%重新排为n列矩阵
row_2=length(O_2)/n;
I=reshape(O_2,n,[]);%!!此处很容易出错，看清reshape的用法
I=I';
number_row=size(I,1);
I(all(I==0,2),:)=[];
I(all(I==1,2),:)=[];

final_I=sum(I);
I_1=mapminmax(final_I,0,1);
I_2=round(mapminmax(I_1,0,1));

k=sum(I_2);
%%
if n==3 && k==2
    m=3;
end
if n==4 && k==2
    m=4;
end

new_yy=new_y{1};

end

