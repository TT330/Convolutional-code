function bitstream2 = Error_set2( bitstream,rate )%%rate С����ʾ
if  rate<0 || rate>=1
error('������Χ������������������');    
end
Length1=length(bitstream);
Temp_bitstream=zeros(1,Length1);
bitstream2 = zeros(1,Length1);
for i=1:Length1
    a=rand(1);
    if a<rate
    Temp_bitstream(1,i)=1;
    else
   Temp_bitstream(1,i)= 0; 
    end
          
end

b=(Temp_bitstream==0);
n=sum(Temp_bitstream(:));

for j=1:Length1
    
 bitstream2(1,j)=xor(bitstream(1,j),Temp_bitstream(1,j)); 
    
end

Number_error=0;
for k=1:Length1
    if bitstream2(1,k)~=bitstream(1,k)
        Number_error=Number_error+1;
    end
    
end


end



