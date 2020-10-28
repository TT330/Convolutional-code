%function [Final_matrix,Partial_Final_matrix,n,k,p,q,flag,count_1] = Blind_Recognize3( bitstream )
function [Final_matrix,n,k,m] = Blind_Recognize3( bitstream )

guess_n=[5,6,7,8];%%实际应用中n不会超过8
    %从5开始逐个进行估计
    for w=1:4    
        length_catch=48*(guess_n(1,w)+1);
        bitstream1=bitstream(1,1:length_catch);%
        
        for i=1:49
        N_matrix(i,:)=bitstream1(1,1+(i-1)*guess_n(1,w) : 1+(i-1)*guess_n(1,w)+47); %按照方程构造系数矩阵
        end
        R=rank(N_matrix);
        New_matrix=gfRref2(N_matrix);
        R1=rank(New_matrix);   
        if(R1<44)   
           break; 
        end
    end
    
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
                end
            end
            
        end
        %%查找数据矩阵中的单位矩阵阶数，b为单位矩阵阶数
        b=0;
        for i=1:48
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
            return ;
        end
        
        
        %%找到全0元素行
        while Final_matrix(another_b,:)==zeros(1,48)

            another_b = another_b+1;
            if another_b>=48
                Final_matrix=0;
                    n=0;
                    k=0;
                return ;
           end
        end

        
               
       Partial_Final_matrix= Final_matrix(another_b:end , :);
  flag=0; 
  flag1=0;
       for p=1:50-another_b
           
            Location_1=find(Partial_Final_matrix(p,:),1);
            Location_2=find(Partial_Final_matrix(p,:),1);
            if(Location_1>Location_2)
                continue;
            end

            
           for n=2:8
               
                
               flag=0;
               count_1=sum(Partial_Final_matrix(p,1:48-n)==1);
               
               for q=1:48-n
                    if Partial_Final_matrix(p,q)==1
                       if Partial_Final_matrix(p,q)==Partial_Final_matrix(p+n,q+n) 
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
        
        if temp_b+another_b-1>=48
                Final_matrix=0;
                    n=0;
                    k=0;
                return ;
        end    
        
        while Partial_Final_matrix(temp_b,temp_b+another_b-1)==1
            if temp_b+another_b-1>=48
                Final_matrix=0;
                n=0;
                k=0;
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
   if k~=1     
        pi=another_b-1+p+k;
        
        m=ceil((n-k)/k * ( ((pi-a) / n) -1) );
   elseif k==1
row1=0;
flag2=0;
        for mi=1:49  %矩阵行数49

            if flag2==1;
                break;
            end
            
            m_flag=0;
            
            mj_start=find(Final_matrix(mi,:),1);
            for mj=mj_start : 48 %矩阵列数48
                
                if Final_matrix(mi,mj)==1%每行开始，从第一列开始，等于1的时候，flag就加一次1，直到等于0，如果flag和n相等，则将该行的行数赋值给row1.
                    m_flag=m_flag+1;
                else
                    if m_flag==n
                        row1=mi;
                        flag2=1;
                    end
                    break;  
                end
                
            end
            
        end
        
        pi=row1+k;
        m=ceil((n-k)/k * ( ((pi-a) / n) -1) );
   end
   
end



