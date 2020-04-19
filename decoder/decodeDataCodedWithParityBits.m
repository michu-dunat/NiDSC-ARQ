%{
rozkodowywanie i zliaczanie niepoprawnie przeslanych pakietow na podstawie
porownania otrzymanego bitu parzystosci z ponownie obliczonym bitem parzystosci
%}
function [decodedPackets, incorrectlyReceivedPacketsAmount] = decodeDataCodedWithParityBits(data)
    incorrectlyReceivedPacketsAmount = 0; % licznik niepoprawnie przeslanych pakietow
    [packetSize, packetAmount] = size(data); % pobranie rozmiaru tablicy
    packetSize = packetSize - 1; % korekcja rozmiaru tablicy
    decodedPackets = zeros(packetSize, packetAmount); % deklaracja i wypelnienie nowej tablicy zerami
    for i = 1 : packetAmount % przechodzenie po kolumnach
        if mod(sum(data(1:packetSize, i)), 2) ~= data(packetSize + 1, i)
            % obliczenie i porownanie bitow parzystosci
            incorrectlyReceivedPacketsAmount = incorrectlyReceivedPacketsAmount + 1; 
        end
        % przepisanie bitow do tablicy
        for j = 1 : packetSize % przechodzenie po wierszach
            decodedPackets(j,i) = data(j, i); % przepisywanie bitow
        end
    end
end