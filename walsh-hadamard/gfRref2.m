function matrix = gfRref2( matrix )
%二元域上的行最简型，不移动非零行
 [ m,n ] = size( matrix );
zuixiaozhi = min ( m,n );

for row = 1:zuixiaozhi
    k= row;
    if matrix(k,row) ~= 0
        for k = row + 1:m;
            if matrix(k,row)~=0;
                for j= row:n;
                    matrix(k,j) = xor( matrix(k,j) , matrix(row,j));%第row行和row行以下的行相加
                end
            end
        end
        for k= 1:row-1
            if matrix(k,row)~=0;
                for j= row:n;
                    matrix(k,j) = xor( matrix(k,j) , matrix(row,j));%第row行和row行以下的行相加
                end
            end
        end
    else
        while k<=m&&matrix(k,row)==0 %寻找第row列中第k行以下的非零元素
            k = k+1;
        end
        if k<=m
            for i=k+1:m %两行相加
                if matrix(i,row)~=0
                    for j= row:n
                        matrix(i,j) = xor(matrix(k,j),matrix(i,j));
                    end
                end
            end
            for i=1:k-1 %两行相加
               if matrix(i,row)~=0
                    for j= row:n
                        matrix(i,j) = xor(matrix(k,j),matrix(i,j));
                    end
               end        
            end
            for j=row:n
                temp  = matrix (k,j);
                matrix(k,j)=matrix(row,j);
                matrix(row,j)=temp;
            end
        end
    end
end

