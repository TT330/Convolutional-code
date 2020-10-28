function Column_Check_Sequence = Check_Sequence( n,k,Final_matrix,a )

       flag3=0;
        
      for p2=1+a:49 %需不需要a？ 
         for q2=p2+1:30
            
           if Final_matrix(p2,q2)==1
              flag3=1;
               break;

           end
          
         end
         if flag3==1
            break;
         end
         
      end
         pi=q2;
         
         for i=a+1:q2+n-k-1
             
             for j=q2:q2+n-k-1
                 
                 if i==j
                    Final_matrix(i,j)=1; 
                     
                 end
                 
             end
         end
         
  if n==3 && k==2
  Column_Check_Sequence = Final_matrix( a+1:a+q2+n-k,q2:q2+n-k-1 );  
  else
  Column_Check_Sequence = Final_matrix( 1:q2+n-k-1,q2:q2+n-k-1 );
  end

end

