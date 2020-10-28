%function [Final_matrix,Partial_Final_matrix,n,k,p,q,flag,count_1] = Blind_Recognize4( bitstream )
function [Final_matrix,n,k,m,q2,a,bitstream1] = Blind_Recognize315( bitstream )

length_catch=33*(3+1);
bitstream1=bitstream(1,1:length_catch);%

        for i=1:34
        N_matrix(i,:)=bitstream1(1,1+(i-1)*3 : 1+(i-1)*3+32); %按照方程构造系数矩阵!!!!!!!!!!
        end
       New_matrix=gfRref2(N_matrix);
        Final_matrix=New_matrix;
        a=0;
        for i=1:3
            sum_row=0;
            sum_column=0;          
            if Final_matrix(i,i)==1
                sum_row=sum(Final_matrix(i,:));
                sum_column=sum(Final_matrix(:,i));
                if sum_row==1 && sum_column==1
                 a=a+1;
                else
                    break;
                end
            end
            
        end
        %%查找数据矩阵中的单位矩阵阶数，b为单位矩阵阶数
        b=0;
        for i=1:33%%!!!!!
           Sub_Final_matrix=Final_matrix(1:i,1:i);
           Temp_matrix=eye(i);
           if  Sub_Final_matrix==Temp_matrix
               b=b+1;
           else
               break;
           end
           
        end
        
        another_b=b+1;
                
        if another_b>=48
            Final_matrix=0;
                n=0;
                k=0;
                m=0;
            return ;
        end
        
        
        %%找到全0元素行
        while Final_matrix(another_b,:)==zeros(1,33)

            another_b = another_b+1;
            if another_b>=33
                Final_matrix=0;
                    n=0;
                    k=0;
                    m=0;
                return ;
           end
        end

        
               
       Partial_Final_matrix= Final_matrix(another_b:end , :);
 % flag=0; 
  flag1=0;
       for p=1:35-another_b
           
            Location_1=find(Partial_Final_matrix(p,:),1);
            Location_2=find(Partial_Final_matrix(p,:),1);
            if(Location_1>Location_2)
                continue;
            end

            
           for n=2:8
               
                
               flag=0;
               count_1=sum(Partial_Final_matrix(p,1:33-n)==1);
               
               for q=1:33-n
                    if Partial_Final_matrix(p,q)==1
                       if Partial_Final_matrix(p:p+n,q)==Partial_Final_matrix(p+n:p+2*n,q+n) 
                         flag=flag+1;  
                       end
                    else
                        continue;
                    end
                    
                    if(flag>=count_1*0.95)
                        flag1=1;
                    end
                                        
               end
               if(flag1==1)
                   break;
               end
               
           end
               if(flag1==1)
                   break;
               end
       end

        k=0;
        temp_b=p;
        
        if temp_b+another_b-1>=33
                Final_matrix=0;
                    n=0;
                    k=0;
                    m=0;
                return ;
        end    
        
        while Partial_Final_matrix(temp_b,temp_b+another_b-1)==1
            if temp_b+another_b-1>=33
                Final_matrix=0;
                n=0;
                k=0;
                m=0;
                return ;
            end 
            
            k=k+1;
            temp_b = temp_b+1;
        end 
        
        if k>=n
          Final_matrix=0;
                    n=0;
                    k=0;
        end
    
        %pi=another_b-1+p+k;
        flag3=0;
        
      for p2=1+a:34  
         for q2=p2+1:30
             
             if p2>=34 || q2>=30
                 n=0;
                 k=0;
                 m=0;
                 return
             end
            
           if Final_matrix(p2,q2)==1
              flag3=1;
               break;

           end
          
         end
         if flag3==1
            break;
         end
         
      end
      
      if n==4 && k==2
         q2=18; 
      end
      
      if n==4 && k==1
          
          q2=10;
          
      end
      if n==5 && k==2
          q2=q2+5; 
      end
      if n==6 && k==1
          q2=9; 
      end      
      
        pi=q2; 
        m=ceil((n-k)/k * ( ((pi-a) / n) -1) );
 
   
end







