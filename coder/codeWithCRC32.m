function codedPackets = codeWithCRC32(data)
    crcgenerator = comm.CRCGenerator('Polynomial','z^32+z^26+z^23+z^22+z^16+z^12+z^11+z^10+z^8+z^7+z^5+z^4+z^2+z+1');
    [packetSize, packetAmount] = size(data);
    for i=1 : packetAmount
        codedPackets(1:packetSize+32, i) = crcgenerator(data(1:packetSize, i));
    end
end