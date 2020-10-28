function Result =Monte_Carlo
Result=zeros(3,1000);
temp_result=zeros(3,1000);
%trellis = poly2trellis(5,[31,21,20,23]);
%trellis=poly2trellis(6,[46,53,75]);
%trellis=poly2trellis(5,[31,21,20,23]);
%trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)
%trellis=poly2trellis(6,[63,51,43,47]);
%trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)
%trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)
%trellis=poly2trellis(4,[15,12])%(2,1,3)
%trellis=poly2trellis(7,[133,171])
%trellis=poly2trellis(6,[53,54])%(2,1,5)
%trellis=poly2trellis([5,5],[30,22,25,30;10,36,13,24])%(4,2,4)OK
trellis=poly2trellis([4,4],[12,15,04;02,02,11])%(3,2,3)
%trellis=poly2trellis(7,[171,165,133])%(3,1,6)
%trellis=poly2trellis(4,[15,7,13])%(3,1,3)
% %trellis=poly2trellis([5,4],[23,35,05;0,05,13])%k=2,n=3
%trellis=poly2trellis(6,[50,51])%(2,1,5)
% %trellis=poly2trellis(7,[133,171])%(2,1,6)
% %trellis=poly2trellis(6,[40,53,75]);%k=1,n=3,约束长度6（3，1，5）系统卷积码
%%trellis=poly2trellis(6,[47,53,75,45,51,73,43,41])%(8,1,5),很少使用
% %trellis=poly2trellis([5,4],[23,35,0;0,05,13])
%trellis=poly2trellis(5,[21,31,33])%(3,1,4)
tic;
for i=1:1000
input=round(rand(1,30000)*1);%生成1行30000列0~1的输入矩阵作为卷积码编码器的输入部分
final_input=[input,[0 0 0 0 0 0 0 0]];%一般来说会在输入最后加入m+1个0   
code_data=convenc(final_input,trellis);%进行卷积码编码
code_data1 = Error_set(code_data,0.00001);    
try
    [Matrix_Data,n,k,m,q2,a,bitstream1]=Blind_Recognize4(code_data1);%识别n,k
    if k==1
    [Generator_Matrix,Oct_Generator_Matrix,m]=Recongnize_Generator2(n,k,m,code_data1);
    else
     Oct_Generator_Matrix=[0,0,0,0,0,0];   
    end
catch
    m=0;
    Oct_Generator_Matrix=[0,0,0,0,0,0];
end


temp_result(1,i)=n;
temp_result(2,i)=k;
temp_result(3,i)=m;
if i==1
A=[temp_result(:,1);Oct_Generator_Matrix'];
Result=A;
else
A=[temp_result(:,i);Oct_Generator_Matrix'];
end  
try
Result=[Result,A]  
catch

end
end

Result
Result'
toc;
end

