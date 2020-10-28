function Result =Monte_Carlo5
%Result=zeros(3,1000);
%trellis=poly2trellis(6,[46,53,75]);
%trellis=poly2trellis(5,[31,21,20,23]);
%trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)
%trellis=poly2trellis(6,[53,54])
%trellis=poly2trellis(6,[63,51,43,47]);
%trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)
%trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)
%trellis=poly2trellis(6,[46,53,75]);
%trellis=poly2trellis(7,[133,170]);
Result=zeros(3,100);
trellis=poly2trellis([4,4],[12,15,04;02,02,11])%(3,2,3)

for i=1:100
temp_result=zeros(3,1000);  
input=round(rand(1,30000)*1);%����1��30000��0~1�����������Ϊ���������������벿��
final_input=[input,[0 0 0 0 0 0 0 0]];%һ����˵��������������m+1��0   
code_data=convenc(final_input,trellis);%���о�������
code_data1 = Error_set2(code_data,0.04);    
   n=0;
   k=0;
   m=0;
try
    [n,k,m]=Walsh_Hadamard( code_data1,250,1000);
    %[k,m,Matrix_Data]= Statistic_km( n,m,code_data1)
catch

end
temp_result(1,i)=n;
temp_result(2,i)=k;
temp_result(3,i)=m;
if i==1
Result(:,i)=temp_result(:,i)
else
Result(:,i)=temp_result(:,i)
end  

end

end


