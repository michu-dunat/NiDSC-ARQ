function codedPackets = codeWithParityBits(packets)
    [packetAmount, packetSize] = size(packets);
    codedPackets = packets;
    for i = 1 : packetAmount
        codedPackets(i, packetSize + 1) = mod(sum(packets(i, 1:packetSize)), 2);
    end
end