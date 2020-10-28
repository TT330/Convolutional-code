function [n,k,m]=Walsh_Hadamard( y,threshold,L)
l_max=27;
l=2;
f=0;
h=0;
d1=0.7;
d2=1.5;
Z=zeros(1,l_max);
for l=2:l_max
    
    if mod(l,2)==0 || mod(l,3)==0 || mod(l,4)==0||mod(l,5)==0||mod(l,6)==0||mod(l,7)==0||mod(l,8)==0 %»Ùl≤ª «2µΩ8µƒ±∂ ˝ l+1
    l=l;
    else
    continue;
    end

R=zeros(L,l);
k=0;
for i=1:L %ππ‘ÏL°¡lΩÿ∂œæÿ’ÛRl
    for j=1:l
        k=k+1;
        R(i,j)=y(1,k);
    end
end

v_index=zeros(1,L);
for i=1:L
    str1=num2str(R(i,1:l));
    str1(find(isspace(str1))) = [];
    v_index(1,i)=bin2dec(str1);

end

v=zeros(1,2^l);

for i=1:L
    location=v_index(1,i);
    location=location+1;
    v(1,location)= v(1,location)+1;
end

% H=hadamard(2^l);
% %∞¢¥Ô¬Ìæÿ’Û◊™ªª”≥…‰
% for i=1:2^l
%     for j=1:2^l
%        if H(i,j)==1
%            H(i,j)=0;
%        elseif H(i,j)==-1
%            H(i,j)=1;
%        end
%         
%     end
%     
% end
% walsh=v*H;

% Walsh-Hadamard±‰ªª
vT=v';%◊™÷√
a=vT;
column=1;
row=2^l;
for i=1:l
    a=[a(1:row/2,:)+a(row/2+1:row,:);a(1:row/2,:)-a(row/2+1:row,:)];
    column=column*2;
    row=row/2;
    a=reshape(a,row,column);
    
end
walsh=a;


for i=2:2^l
    if walsh(1,i)>threshold
        Z(1,l)=Z(1,l)+1;
    end
end

peak_walsh=max(walsh(1,2:end));

if peak_walsh>max(threshold,d1*h)
    
    if f==0 || f==l-1 || peak_walsh>d2*h
        f=l;
        h=peak_walsh;
    else
        n=l-f;
        k=floor((l-log2(Z(1,l)+1)) - (f-log2(Z(1,f)+1)));
        m=ceil((f-log2(Z(1,f)+1)) - f*k/n);
        
        if n==3 && k==2
            m=m/2;
        end
        if n==4 && k==2
            m=m-2;
        end
        
        stem(0:1:2^l-1,walsh,'.k')
        hold on;
        plot([0,2^l-1],[threshold,threshold],'--r');
        s=sprintf('R%dΩÿ∂œæÿ’ÛWalsh-Hadmard',l);
        title(s);
        xlim([0,2^l-1]);
        ylim([-200,2000]);
        return;

    end
    
end

stem(0:1:2^l-1,walsh,'.k')
s=sprintf('R%dΩÿ∂œæÿ’ÛWalsh-Hadmard',l);
hold on;
plot([0,2^l-1],[threshold,threshold],'--r');
title(s);
xlim([0,2^l-1]);
ylim([-200,1000])
end


end
