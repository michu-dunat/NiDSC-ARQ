function [decodedPackets, incorrectlyReceivedPacketsAmount] = decodeDataCodedWithParityBits(data)
    incorrectlyReceivedPacketsAmount = 0;
    [packetSize, packetAmount] = size(data);
    packetSize = packetSize - 1;
    decodedPackets = data;
    for i = 1 : packetAmount
        decodedPackets(packetSize + 2,i) = mod(sum(data(1:packetSize, i)), 2);
        if decodedPackets(packetSize + 1, i) ~= decodedPackets(packetSize + 2 , i)
            incorrectlyReceivedPacketsAmount = incorrectlyReceivedPacketsAmount + 1;
        end
    end
end