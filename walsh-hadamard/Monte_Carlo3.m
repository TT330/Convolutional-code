function Result =Monte_Carlo3
%Result=zeros(3,1000);
trellis=poly2trellis(6,[46,53,75]);
%trellis=poly2trellis(5,[31,21,20,23]);
%trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)
%trellis=poly2trellis(6,[53,54])
%trellis=poly2trellis(6,[63,51,43,47]);
%trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)
%trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)
%trellis=poly2trellis(6,[46,53,75]);
%trellis=poly2trellis(7,[133,170]);
delete(gcp('nocreate'));
p=parpool(4);
tic
parfor i=1:1000
temp_result=zeros(3,1000);  
input=round(rand(1,30000)*1);%����1��30000��0~1�����������Ϊ���������������벿��
final_input=[input,[0 0 0 0 0 0 0 0]];%һ����˵��������������m+1��0   
code_data=convenc(final_input,trellis);%���о�������
code_data1 = Error_set2(code_data,0.002);    
try
    [n,k,m]=Walsh_Hadamard( code_data1,500,1000);

    %[~,m,Matrix_Data]= Statistic_km( n,m,code_data1)
    k=1
    if k==1
    [~,Oct_Generator_Matrix,m]=Recongnize_Generator2(n,k,m,code_data1)
    else
    Oct_Generator_Matrix=[0,0,0,0,0,0];   
    end
   
catch
    k=0;
    m=0;
    Oct_Generator_Matrix=[0,0,0,0,0,0]; 
end
temp_result(1,i)=n;
temp_result(2,i)=k;
temp_result(3,i)=m;
if i==1
Result(:,i)=[temp_result(:,i);Oct_Generator_Matrix']
else
Result(:,i)=[temp_result(:,i);Oct_Generator_Matrix']
end  

end
delete(p)
toc
end


