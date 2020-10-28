%function [Final_matrix,Partial_Final_matrix,n,k,p,q,flag,count_1] = Blind_Recognize4( bitstream )
function [Final_matrix,n,k,m,q2,a,bitstream1] = Blind_Recognize4( bitstream )

guess_n=[5,6,7,8];%%ʵ��Ӧ����n���ᳬ��8
    %��5��ʼ������й���
    Store=zeros(1,4);
    for w=1:4    
        length_catch=48*(guess_n(1,w)+1);
        bitstream1=bitstream(1,1:length_catch);%
        
        for i=1:49
        N_matrix(i,:)=bitstream1(1,1+(i-1)*guess_n(1,w) : 1+(i-1)*guess_n(1,w)+47); %���շ��̹���ϵ������
        end
        New_matrix=gfRref2(N_matrix);
        R1=rank(New_matrix); 
        Store(1,w)=R1;
%         if(R1<44)   
%            break; 
%         end

    end
        
       [www,index]=min(Store);
        for i=1:49
        N_matrix(i,:)=bitstream1(1,1+(i-1)*guess_n(1,index) : 1+(i-1)*guess_n(1,index)+47); %���շ��̹���ϵ������
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
        %%�������ݾ����еĵ�λ���������bΪ��λ�������
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
                m=0;
            return ;
        end
        
        
        %%�ҵ�ȫ0Ԫ����
        while Final_matrix(another_b,:)==zeros(1,48)

            another_b = another_b+1;
            if another_b>=48
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
        
        if temp_b+another_b-1>=48
                Final_matrix=0;
                    n=0;
                    k=0;
                    m=0;
                return ;
        end    
        
        while Partial_Final_matrix(temp_b,temp_b+another_b-1)==1
            if temp_b+another_b-1>=48
                Final_matrix=0;
                n=0;
                k=0;
                m=0;
                return ;
            end 
            
            k=k+1;
            temp_b = temp_b+1;
        end 
        if k>=3
            n=2;
           for i=0:k-1
            if Final_matrix(another_b+i,another_b+i)==1 && Final_matrix(another_b+i,another_b+1+i)==0
              n=n+1;
            end
           end
        end
        
        
        
        
        if k>=n
          Final_matrix=0;
                    n=0;
                    k=0;
        end
    
        %pi=another_b-1+p+k;
        flag3=0;
        
      for p2=1+a:49  
         for q2=p2+1:30
             
             if p2>=49 || q2>=48
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
      
%       if n==4 && k==2
%          q2=18; 
%       end
%       
%       if n==4 && k==1
%           
%           q2=10;
%           
%       end
%       if n==5 && k==2
%           q2=q2+5; 
%       end
%       if n==6 && k==1
%           q2=9; 
%       end      
%       
        
       
       q2=another_b+n-1;
       pi=q2; 
        m=ceil((n-k)/k * ( ((pi-a) / n) -1) );
 
   
end





