function  [Generator_Matrix,Oct_Generator_Matrix,m] = Recongnize_Generator2(n,k,m,bitstream)
%function  n = Recongnize_Generator(Check_Sequence,n,k,bitstream)

   %针对n为偶数 
    if k==1 
        groups=ceil(n/2);%分成n/2组
        duoyu=mod(length(bitstream),n);%很重要！！！！！！！！！确保任意起始位置都可以进行识别
        bitstream2=reshape(bitstream(1,1+duoyu:end),n,[]);%将bit流转换成 n行，方便提取
        Oct_Generator_Matrix=zeros(1,1);
        if mod(n,2)==0
            for group=1:groups      
              New_bitstream = bitstream2(2*group-1:2*group,:);  
              New_bitstream1=reshape(New_bitstream,[],1);
              New_bitstream1=New_bitstream1';
              length_catch=16*(2+1);
              New_bitstream2=New_bitstream1(1,1:length_catch);
              
                for i=1:17
                N_matrix(i,:)=New_bitstream2(1,1+(i-1)*2 : 1+(i-1)*2+15); %按照方程构造系数矩阵
                end
                New_matrix=gfRref2(N_matrix);       
              
                flag3=0;
                   for p2=1:17 %需不需要a？ 
                     for q2=p2+1:16

                       if New_matrix(p2,q2)==1
                          flag3=1;
                           break;

                       end

                     end
                     if flag3==1
                        break;
                     end

                   end
                   pi=q2;
                   
              %  q2=2*(m+1);
                   
                   
         
                 for i=1:q2

                     for j=q2
                         if i==j
                           New_matrix(i,j)=1; 

                         end

                     end
                 end
                 
       %Column_Check_Sequence = New_matrix( 1:2*(m+1),q2);
       if q2==0
           Generator_Matrix=0;
           Oct_Generator_Matrix=0;
           m=0;
           return
       end
       Column_Check_Sequence = New_matrix( 1:q2,q2);
        LEN=length(Column_Check_Sequence(:,1));
        Initial_Generator=zeros(LEN/2,2);
        
        j=1;
        for i=1:2:LEN-1
           if j<=LEN/2
                Initial_Generator(j,1)=Column_Check_Sequence(i,1);
                Initial_Generator(j,2)=Column_Check_Sequence(i+1,1);   
                j=j+1;
           else
               break;
           end
        end 
     Generator_Matrix=rot90(Initial_Generator,2);   %将矩阵逆时针旋转180°
     str1=num2str(Generator_Matrix(:,1));
     y_1=bin2dec(str1');
     y_1=dec2base(y_1,8);
     y_1=str2num(y_1);
     str2=num2str(Generator_Matrix(:,2));
     y_2=bin2dec(str2');
     y_2=dec2base(y_2,8);
     y_2=str2num(y_2);
     Oct_Generator_Matrix_temp=[y_1,y_2];
     Oct_Generator_Matrix=[Oct_Generator_Matrix Oct_Generator_Matrix_temp] ;
            end
     Oct_Generator_Matrix=Oct_Generator_Matrix(1,2:end);
     m=q2/2-1;
     
 %针对n为奇数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif mod(n,2)~=0
        duoyu=mod(length(bitstream),n);
        bitstream2=reshape(bitstream(1,1+duoyu:end),n,[]);
            for group=1:groups
              if group==groups
                  New_bitstream = bitstream2(2*(group-1):2*group-1,:);  %取两行
                  New_bitstream1=reshape(New_bitstream,[],1);
                  New_bitstream1=New_bitstream1';
                  length_catch=16*(2+1);
                  New_bitstream2=New_bitstream1(1,1:length_catch); 
              else
                  New_bitstream = bitstream2(2*group-1:2*group,:);  %取两行
                  New_bitstream1=reshape(New_bitstream,[],1);
                  New_bitstream1=New_bitstream1';
                  length_catch=16*(2+1);
                  New_bitstream2=New_bitstream1(1,1:length_catch);
              end

              
                for i=1:17
                N_matrix(i,:)=New_bitstream2(1,1+(i-1)*2 : 1+(i-1)*2+15); %按照方程构造系数矩阵
                end
                New_matrix=gfRref2(N_matrix);       
              
                flag3=0;
                   for p2=1:17 %需不需要a？ 
                     for q2=p2+1:16

                       if New_matrix(p2,q2)==1
                          flag3=1;
                           break;
                       end

                     end
                     if flag3==1
                        break;
                     end

                   end
                 
                   %aa=New_matrix(q2,q2);
%                    if New_matrix(1,q2)==1
%                        
%                        q2=q2+2;
%                        
%                    end
                    if New_matrix(1:q2,q2)==New_matrix(3:q2+2,q2+2) 
                        if(New_matrix(1,q2+2)==1 || New_matrix(2,q2+2)==1)
                        q2=q2+2;
                        end
                    end

                   %q2=2*(m+1)
                  pi=q2;%%??

                 for i=1:q2

                     for j=q2
                         if i==j
                           New_matrix(i,j)=1; 

                         end

                     end
                 end
                 
      % Column_Check_Sequence = New_matrix( 1:2*(m+1),q2);
      
      if mod(q2,2)~=0
     Column_Check_Sequence = New_matrix( 1:q2+1,q2); 
      else
   Column_Check_Sequence = New_matrix( 1:q2,q2);     
      end
      
 
        LEN=length(Column_Check_Sequence(:,1));
        j=1;
        for i=1:2:LEN-1
           if j<=LEN/2
                Initial_Generator(j,1)=Column_Check_Sequence(i,1);
                Initial_Generator(j,2)=Column_Check_Sequence(i+1,1);   
                j=j+1;
           else
               break;
           end
        end 
     Generator_Matrix=rot90(Initial_Generator,2);   %将矩阵逆时针旋转180°
     str1=num2str(Generator_Matrix(:,1));
     y_1=bin2dec(str1');
     y_1=dec2base(y_1,8);
     y_1=str2num(y_1);
     str2=num2str(Generator_Matrix(:,2));
     y_2=bin2dec(str2');
     y_2=dec2base(y_2,8);
     y_2=str2num(y_2);
     Oct_Generator_Matrix_temp=[y_1,y_2];
     Oct_Generator_Matrix=[Oct_Generator_Matrix Oct_Generator_Matrix_temp] ;
            end
     Oct_Generator_Matrix=Oct_Generator_Matrix(1,2:end);
     Oct_Generator_Matrix(:,n)=[];
     
     if mod(q2,2)~=0
     m=(q2+1)/2-1;
     else
      m=q2/2-1;
      end
     
     
     
          
         
        end
        
        
    end
    
    
    
end

