function codedPackets = codeWithParityBits(packets)
    [packetSize, packetAmount] = size(packets);
    codedPackets = packets;
    for i = 1 : packetAmount
        codedPackets(packetSize + 1,i) = mod(sum(packets(1:packetSize,i)), 2);
    end
end