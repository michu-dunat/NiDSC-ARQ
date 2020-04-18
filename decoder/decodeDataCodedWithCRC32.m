function [decodedPackets, incorrectlyReceivedPacketsAmount] = decodeDataCodedWithCRC32(data)
    incorrectlyReceivedPacketsAmount = 0;
    [packetSize, packetAmount] = size(data);
    packetSize = packetSize - 32;
    crcDetector = comm.CRCDetector('Polynomial','z^32+z^26+z^23+z^22+z^16+z^12+z^11+z^10+z^8+z^7+z^5+z^4+z^2+z+1');
    decodedPackets = [];
    for i = 1 : packetAmount
        [decodedPackets(1:packetSize, i), err(i)] = crcDetector(data(1:packetSize+32, i));
        incorrectlyReceivedPacketsAmount = incorrectlyReceivedPacketsAmount + sum(err(i));
    end
end