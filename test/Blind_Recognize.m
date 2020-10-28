% 暂时不用
% function [Final_matrix,n,k] = Blind_Recognize( bitstream )
% guess_n=[5,6,7,8];
%     for q=1:4    
%         length_catch=48*(guess_n(1,q)+1);
%         bitstream1=bitstream(1,1:length_catch);
%         
%         for i=1:49
%         N_matrix(i,:)=bitstream1(1,1+(i-1)*guess_n(1,q) : 1+(i-1)*guess_n(1,q)+47); 
%         end
%         R=rank(N_matrix);
%         New_matrix=gfRref2(N_matrix);
%         R1=rank(New_matrix);   
%         if(R1<44)   
%            break; 
%         end
%     end
%     
%         Final_matrix=New_matrix;
%         a=0;
%         for i=1:48
%             sum_row=0;
%             sum_column=0;          
%             if Final_matrix(i,i)==1
%                 sum_row=sum(Final_matrix(i,:));
%                 sum_column=sum(Final_matrix(:,i));
%                 if sum_row==1 && sum_column==1
%                  a=a+1;
%                 end
%             end
%             
%         end
%         %%查找数据矩阵中的单位矩阵阶数，b为单位矩阵阶数
%         b=0;
%         for i=1:48
%            Sub_Final_matrix=Final_matrix(1:i,1:i);
%            Temp_matrix=eye(i);
%            if  Sub_Final_matrix==Temp_matrix
%                b=b+1;
%            else
%                break;
%            end
%            
%         end
%         another_b=b+1;
%         
%         %%找到全0元素行
%         while Final_matrix(another_b,:)==zeros(1,48)
%             another_b = another_b+1;
%         end
%         
%         temp_b=another_b;
%         k=0;
%         
%         while Final_matrix(temp_b,temp_b)==1
%         k=k+1;
%         temp_b = temp_b+1;
%         end
%         
%         Partial_Final_matrix= Final_matrix(another_b:end , :);
%         
% 
% flag1=0;
%             for n=2:8     
%                 
%                 if flag1==1
%                     n=n-1;
%                     break;
%                 end
%                 
%                 for j=1:k
%                     flag=0;
% 
%                     for w=1:48-n
%                         if Partial_Final_matrix(j,w)==Partial_Final_matrix(j+n,w+n)
%                             flag=flag+1;
%                         end              
%                     end
%                     
%                     if(flag==48-n && j==k)
%                         flag1=1;
%                         break;
%                     end
% 
%                   
%                 end
%             
%             end
%             
% 
%         
%         
% end
% 
