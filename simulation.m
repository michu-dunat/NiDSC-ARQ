clear; 
% pokaz mozliwosci symulatora na dzien 22.05.2020

% Dane poczatkowe
packetAmount = 1000;
packetSize = 1000;
errorProbability = 0.0001;
goodToBadProbability = 0.002;
badToGoodProbability = 0.8;
codingType = 'CRC32';  % 'CRC32' or 'PB'
channel = 'BSC'; % 'BSC' or 'GILBERT'

% przed wejsciem do ARQ
data = generatePackets(packetSize, packetAmount);
result = zeros(packetSize, packetAmount);

% wybor typu kodowania
switch codingType
    case 'PB'
        codedData = codeWithParityBits(data);
    case 'CRC32'
        codedData = codeWithCRC32(data);
end

errorRate = 0;
n = 0;  % sumaryczna liczba przeslanych pakietow z uwzglednieniem retransmisji
allBitsSent = 0;
redundantBitsFromCoding = 0;
redundantBitsFromRetransmission = 0;

for i = 1 : packetAmount
    
  isNotCorrect = true;
  counter = 0;
  
  while(isNotCorrect) 
      
    switch channel
        case 'BSC'
            sentData = sendDataThroughBSC(codedData(:,i), errorProbability);
        case 'GILBERT'
            sentData = sendDataThroughGilbert(codedData(:,i), goodToBadProbability, badToGoodProbability);
    end
    
    % dekodowanie
    switch codingType
    case 'PB'
        [decodedData, err] = decodeDataCodedWithParityBits(sentData);
         redundantBitsFromCoding = redundantBitsFromCoding + 1;
            if counter > 0
                redundantBitsFromRetransmission = redundantBitsFromRetransmission + size(decodedData,1);
            end
    case 'CRC32'
        [decodedData, err] = decodeDataCodedWithCRC32(sentData);
        redundantBitsFromCoding = redundantBitsFromCoding + 33;
            if counter > 0
                redundantBitsFromRetransmission = redundantBitsFromRetransmission + size(decodedData,1);
            end
    end
    
    if err>0 
        isNotCorrect = true;
        errorRate = errorRate+err;
        counter = counter + 1;
    else
        isNotCorrect=false;
        result(1:packetSize,i) = decodedData;
    end
    
    n = n+1;
    allBitsSent = allBitsSent + size(sentData,1);
  end
end

disp('Ilosc pakietow:');
disp(n);
disp('Ilosc bledow:');
disp(errorRate);
disp('Wszystkie przeslane bity: ');
disp(allBitsSent);
disp('Nadmiarowe bity wynikające z retransmisji');
disp(redundantBitsFromRetransmission);
disp('Nadmiarowe bity wynikające z kodowania');
disp(redundantBitsFromCoding);