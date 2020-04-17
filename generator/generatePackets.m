function packets = generatePackets(packetAmount, packetSize)
    packets = randi([0, 1], packetAmount, packetSize); %returns a 1-by-sizeOfPacket array of pseudorandom bits.
end