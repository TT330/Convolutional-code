function convolution_output = Random_Convolution_Encoder( final_input )

r=randi([1,16],1);

switch r
    case 1
    trellis=poly2trellis(4,[15,12])%(2,1,3)   
    case 2
    trellis=poly2trellis(6,[53,54])%(2,1,5)
    case 3
    trellis=poly2trellis(7,[133,170])%(2,1,6) IEEE 802.11a协议中规定卷积编码使用的生成多项式 g0 = 133（8进制）和 g1 = 171（8进制），码率为1/2。
    case 4
    trellis=poly2trellis(4,[12,15,13,16,10,13])%(6,1,3)   
    case 5
    trellis=poly2trellis(6,[53,54,51,52,61,63])%(6,1,5)    
    case 6
    trellis=poly2trellis(6,[47,53,75,45,51,73])%(6,1,5)   
    case 7
    trellis=poly2trellis(5,[31,21,20,23]);%(4,1,4)    
    case 8
    trellis=poly2trellis(6,[63,51,43,47]);%(4,1,5)必须是奇数
    case 9
    trellis=poly2trellis(6,[40,53,75]);%k=1,n=3,约束长度6（3，1，5）系统卷积码    
    case 10
    trellis=poly2trellis(6,[46,53,75]);%k=1,n=3,约束长度6（3，1，5）非系统卷积码   
    case 11
    trellis=poly2trellis(7,[171,165,133])%(3,1,6)   
    case 12
    trellis=poly2trellis(5,[21,31,33])%(3,1,4)
    case 13
    trellis=poly2trellis(5,[21,23,25,26,27])%(5,1,4)  
    case 14
    trellis=poly2trellis([5,5],[21,23,25,27,15;26,31,33,37,34])%5,2,4
    case 15
    trellis=poly2trellis([4,4],[12,15,4;02,02,11])%(3,2,3)  
    case 16
    trellis=poly2trellis([5,5],[30,22,25,30;10,36,13,24])%(4,2,4)OK   
    case 17
    trellis=poly2trellis(4,[15,7,13])%(3,1,3)
end

convolution_output=convenc(final_input,trellis);



end

