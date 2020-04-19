clear; 
% pokaz mozliwosci symulatora na dzien 19.04.2020
data = generatePackets(30, 100);
dataCodedWithParityBits = codeWithParityBits(data);
dataCodedWithCRC32 = codeWithCRC32(data);
dataParityBSC = sendDataThroughBSC(dataCodedWithParityBits, 0.001);
dataCRC32Gilbert = sendDataThroughGilbert(dataCodedWithCRC32, 0.001, 0.8);
[decodedParity, errParity] = decodeDataCodedWithParityBits(dataParityBSC);
[decodedCRC32, errCRC32] = decodeDataCodedWithCRC32(dataCRC32Gilbert);
disp('Ilosc bledow przy przesylaniu przez BSC (bit parzystosci):');
disp(errParity);
disp('Ilosc bledow przy przesylaniu przez Gilberta (CRC32):');
disp(errCRC32);