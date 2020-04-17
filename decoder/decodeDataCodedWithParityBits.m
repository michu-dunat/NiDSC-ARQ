function [decodedPackets, incorrectlyReceivedPacketsAmount] = decodeDataCodedWithParityBits(data)
    incorrectlyReceivedPacketsAmount = 0;
    [packetAmount, packetSize] = size(data);
    packetSize = packetSize - 1;
    decodedPackets = data;
    for i = 1 : packetAmount
        decodedPackets(i, packetSize + 2) = mod(sum(data(i, 1:packetSize)), 2);
        if decodedPackets(i, packetSize + 1) ~= decodedPackets(i, packetSize + 2)
            incorrectlyReceivedPacketsAmount = incorrectlyReceivedPacketsAmount + 1;
        end
    end
end