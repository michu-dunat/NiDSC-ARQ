%{
rozkodowywanie i zliaczanie niepoprawnie przeslanych pakietow z
wykorzystaniem CRC32, w tym celu zostaje wykorzystana oficjalna 
biblioteka Communication Toolbox
%}
function [decodedPackets, incorrectlyReceivedPacketsAmount] = decodeDataCodedWithCRC32(data)
    incorrectlyReceivedPacketsAmount = 0; % licznik niepoprawnie przeslanych pakietow
    [packetSize, packetAmount] = size(data); % pobranie rozmiaru tablicy
    packetSize = packetSize - 32; % korekcja rozmiaru tablicy
    % deklaracja dekodera sum częsciowych, pierwszy argument oznacza
    % wielomian, drugi argument oznacza typ CRC - w tym przypadku CRC32
    crcDetector = comm.CRCDetector('Polynomial','z^32+z^26+z^23+z^22+z^16+z^12+z^11+z^10+z^8+z^7+z^5+z^4+z^2+z+1');
    decodedPackets = zeros(packetSize, packetAmount); % deklaracja i wypelnienie nowej tablicy zerami
    for i = 1 : packetAmount % przejscie po wszystkich pakietach
        % przepisanie wartosci i zliczanie niepoprawnie przeslanych pakietow
        [decodedPackets(1:packetSize, i), err(i)] = crcDetector(data(1:packetSize+32, i));
        incorrectlyReceivedPacketsAmount = incorrectlyReceivedPacketsAmount + sum(err(i));
    end
end