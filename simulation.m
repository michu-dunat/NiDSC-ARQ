clear; 

%x = generatePackets(2, 4);
%y = codeWithParityBits(x);
%disp(y);
%z = sendDataThroughBSC(y, 0.01);
%disp(z);
%[a, b] = decodeDataCodedWithParityBits(z);
%display(a);
%display(b);


x = generatePackets(2,20);
disp('msg: ');
disp(x);
%y = codeWithCRC32(x);
%disp(y);
z = sendDataThroughGilbert(x, 0,1);
%disp(z);
%crcDetector = comm.CRCDetector('Polynomial','z^32+z^26+z^23+z^22+z^16+z^12+z^11+z^10+z^8+z^7+z^5+z^4+z^2+z+1');
%[msg,err] = crcDetector(z);
%display(msg);
%display(err);
disp(z);



