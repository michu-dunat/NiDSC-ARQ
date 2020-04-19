%{
funkcja generuje zakodowane pakiety z wykorzystaniem CRC32
sumy kontrolne zostaja dolaczone do tablicy jako ostatnie 32 wiersze
zostaje wykorzystana tutaj oficjalna biblioteka Communication Toolbox
%}
function codedPackets = codeWithCRC32(data)
    % deklaracja generatora sum częsciowych, pierwszy argument oznacza
    % wielomian, drugi argument oznacza typ CRC - w tym przypadku CRC32
    crcgenerator = comm.CRCGenerator('Polynomial','z^32+z^26+z^23+z^22+z^16+z^12+z^11+z^10+z^8+z^7+z^5+z^4+z^2+z+1'); 
    [packetSize, packetAmount] = size(data); % pobranie rozmiaru tablicy
    codedPackets = zeros(packetSize + 32, packetAmount); % deklaracja i wypelnienie nowej tablicy zerami
    for i = 1 : packetAmount
        codedPackets(1:packetSize+32, i) = crcgenerator(data(1:packetSize, i)); % obliczanie i dolaczanie sum czesciowych
    end
end