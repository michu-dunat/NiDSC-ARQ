function packets = generatePackets(packetAmount, packetSize)
    packets = randi([0, 1], packetSize, packetAmount);
end