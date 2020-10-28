function bitstream2 = Error_set( bitstream,rate )%%rate 小数表示
%rate=rate*0.01;
    if  rate<0 || rate>=1
    error('超出范围，请重新输入误码率');    
    end
Length1=length(bitstream);
Number_error=ceil(Length1*rate);
p = randperm(Length1,Number_error);%%p = randperm(n,k) 返回一行从1到n的整数中的k个，而且这k个数也是不相同的。
bitstream2=bitstream;
c=0;
    for i=1:Number_error
        
        if bitstream2(1,p(1,i))==1
         bitstream2(1,p(1,i))=0;
        else 
        bitstream2(1,p(1,i))=1;
        end
        
    end
    for j=1:Length1
    if bitstream(1,j)~=bitstream2(1,j)
        c=c+1;
    end
    end
    
    if c~=Number_error
        error('误码率异常');
    end
    
end

