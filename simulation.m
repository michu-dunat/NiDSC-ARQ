clear; 

x = generatePackets(4, 5);
disp(x);
y = codeWithParityBits(x);
disp(y);
z = sendDataThroughBSC(y, 0.2);
disp(z);
[a, b] = decodeDataCodedWithParityBits(z);
display(a);
display(b);