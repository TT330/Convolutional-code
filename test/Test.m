 clear all
% %trellis=poly2trellis([5,5],[30,22,25,30;10,36,13,24])%(4,2,4)OK
% %trellis=poly2trellis([4,4],[12,15,04;02,02,11])%(3,2,3)
% %trellis=poly2trellis(7,[171,165,133])%(3,1,6)
%trellis=poly2trellis(4,[15,7,13])%(3,1,3)
% %trellis=poly2trellis([5,4],[23,35,05;0,05,13])%k=2,n=3
%trellis=poly2trellis(6,[50,51])%(2,1,5)
% %trellis=poly2trellis(7,[133,171])%(2,1,6)
% %trellis=poly2trellis(6,[40,53,75]);%k=1,n=3,Լ������6��3��1��5��ϵͳ�����
% %trellis=poly2trellis(6,[47,53,75,45,51,73,43,41])%(8,1,5),����ʹ��
% %trellis=poly2trellis([5,4],[23,35,0;0,05,13])
% 
% %Ŀǰ 1/2���ʾ����Ӷ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trellis=poly2trellis(4,[15,12])%(2,1,3)
%trellis=poly2trellis(6,[53,54])%(2,1,5)
%trellis=poly2trellis(7,[133,170])%(2,1,6) IEEE 802.11aЭ���й涨�������ʹ�õ����ɶ���ʽ g0 = 133��8���ƣ��� g1 = 171��8���ƣ�������Ϊ1/2��
% trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)
%trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)
%trellis=poly2trellis(6,[46,53,75,45,51,73])%(6,1,5)
%trellis=poly2trellis(5,[31,21,20,23]);%(4,1,4)
%trellis=poly2trellis(6,[63,51,43,47]);%(4,1,5)����������
% 
%trellis=poly2trellis([5,5,5],[21,31,33,20;26,20,23,31;25,25,26,27])%(4,3,4)

%trellis=poly2trellis(6,[40,53,75]);%k=1,n=3,Լ������6��3��1��5��ϵͳ�����
%trellis=poly2trellis(6,[46,53,75]);%k=1,n=3,Լ������6��3��1��5����ϵͳ�����
 %trellis=poly2trellis(7,[171,165,133])%(3,1,6)
%trellis=poly2trellis(5,[21,31,33])%(3,1,4)
%trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)
% 
% 
%trellis=poly2trellis([5,5],[21,23,25,27,15;26,31,33,37,34])%5,2,4
trellis=poly2trellis([4,4],[12,15,4;02,02,11])%(3,2,3)
%trellis=poly2trellis([5,5],[30,22,25,30;10,36,13,24])%(4,2,4)OK
% 
input=round(rand(1,30000)*1);%����1��30000��0~1�����������Ϊ���������������벿��
% 
final_input=[input];%һ����˵��������������m+1��0
 
code_data=convenc(final_input,trellis);%���о�������
%code_data=Random_Convolution_Encoder( final_input );%���������
% 
% %code_data1=Error_set(code_data,0.015);%%�����������,��ǰ������Ϊ0
 code_data1 = Error_set2(code_data,0);
%[A,B,n,k,p,q,flag,count_1]=Blind_Recognize3(code_data1)

[Matrix_Data,n,k,m,q2,a,bitstream1]=Blind_Recognize4(code_data1)%ʶ��n,k

 %P=Check_Sequence( n,k,Matrix_Data,a )

if k==1
[Generator_Matrix,Oct_Generator_Matrix,m]=Recongnize_Generator2(n,k,m,code_data1)
end
%Result=Monte_Carlo


