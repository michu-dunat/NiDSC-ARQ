function [errorAmount, n, allBitsSent, redundantBitsFromCoding, redundantBitsFromRetransmission, result] = stopAndWaitARQ(packetAmount, packetSize, errorProbability, goodToBadProbability, badToGoodProbability,codingType, channel)

    data = generatePackets(packetSize, packetAmount);
    result = zeros(packetSize, packetAmount);

    % wybor typu kodowania
    switch codingType
        case 'PB'
            codedData = codeWithParityBits(data);
        case 'CRC32'
            codedData = codeWithCRC32(data);
    end

    errorAmount = 0;
    n = 0;  % sumaryczna liczba przeslanych pakietow z uwzglednieniem retransmisji
    allBitsSent = 0;
    redundantBitsFromCoding = 0;
    redundantBitsFromRetransmission = 0;

    for i = 1 : packetAmount

        isNotCorrect = true;
        counter = 0;

        while(isNotCorrect)

            %przesylanie
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

            % ponowna retransmisja
            if err>0 
                isNotCorrect = true;
                errorAmount = errorAmount + err;
                counter = counter + 1;
            % przejscie do nastpnego pakietu
            else
                isNotCorrect = false;
                result(1:packetSize,i) = decodedData;
            end

            n = n+1;
            allBitsSent = allBitsSent + size(sentData,1);
        end
    end

end