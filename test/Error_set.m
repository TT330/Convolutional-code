function bitstream2 = Error_set( bitstream,rate )%%rate С����ʾ
%rate=rate*0.01;
    if  rate<0 || rate>=1
    error('������Χ������������������');    
    end
Length1=length(bitstream);
Number_error=ceil(Length1*rate);
p = randperm(Length1,Number_error);%%p = randperm(n,k) ����һ�д�1��n�������е�k����������k����Ҳ�ǲ���ͬ�ġ�
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
        error('�������쳣');
    end
    
end

