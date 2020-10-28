clear all 
% %目前 1/2码率卷积码居多%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trellis=poly2trellis(4,[15,12])%(2,1,3)
%trellis=poly2trellis(6,[53,54])%(2,1,5)
%trellis=poly2trellis(7,[133,170])%(2,1,6) IEEE 802.11a协议中规定卷积编码使用的生成多项式 g0 = 133（8进制）和 g1 = 171（8进制），码率为1/2。
%trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)
%trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)
%trellis=poly2trellis(6,[46,53,75,45,51,73])%(6,1,5)
%trellis=poly2trellis(5,[31,21,20,23]);%(4,1,4)
%trellis=poly2trellis(6,[63,51,43,47]);%(4,1,5)必须是奇数
%trellis=poly2trellis(6,[40,53,75]);%k=1,n=3,约束长度6（3，1，5）系统卷积码
%trellis=poly2trellis(6,[46,53,75]);%k=1,n=3,约束长度6（3，1，5）非系统卷积码
%trellis=poly2trellis(7,[171,165,133])%(3,1,6)
%trellis=poly2trellis(5,[21,31,33])%(3,1,4)
%trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)
%trellis=poly2trellis([2,2],[2,0,3;0,2,1])%(3,2,1)
%trellis=poly2trellis([5,5],[21,23,25,27,15;26,31,33,37,34])%5,2,4
%trellis=poly2trellis([4,4],[12,15,04;10,02,11])%(3,2,3)
%trellis=poly2trellis([5,5],[30,22,25,30;10,36,15,24])%(4,2,4)OK
input=randi([0 1],1,30000);%生成1行30000列0~1的输入矩阵作为卷积码编码器的输入部分
final_input=[input,[0 0 0 0 0 0 0 0 0]];%一般来说会在输入最后加入m+1个0
code_data=convenc(final_input,trellis);%进行卷积码编码
code_data1 = Error_set2(code_data,0);
%code_data1 =code_data1(1,5:end);
[n,k,m]=Walsh_Hadamard( code_data1,155,1000)

%[k,m,Matrix_Data]= Statistic_km( n,m,code_data1)


if k==1
[Generator_Matrix,Oct_Generator_Matrix,m]=Recongnize_Generator2(n,k,m,code_data1)
end


x=4.4
xx=x/10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
xxx=10^xx
BER1=erfc(sqrt(xxx))
BER=1/2*erfc(sqrt(xxx))
