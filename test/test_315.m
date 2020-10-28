trellis=poly2trellis(6,[40,53,75])
input=round(rand(1,30000)*1);
final_input=[input,[0 0 0 0 0 0 0 0]];
code_data=convenc(final_input,trellis);
code_data1 = Error_set2(code_data,0.014);
[Matrix_Data,n,k,m,q2,a,bitstream1]=Blind_Recognize315(code_data1)
