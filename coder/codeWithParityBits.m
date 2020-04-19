%{
funkcja generuje zakodowane pakiety z wykorzystaniem bitu parzystosci
bity parzystosci zostaja dolaczone do tablicy w ostatnim wierszu
0 oznacza parzysta ilosc jedynek, 1 oznacza nieparzysta ilosc jedynek
%}
function codedPackets = codeWithParityBits(packets)
    [packetSize, packetAmount] = size(packets); % pobranie rozmiaru tablicy
    codedPackets = packets; % przepisanie tablicy do nowej zmiennej
    for i = 1 : packetAmount % petla po kolumnach 
        codedPackets(packetSize + 1,i) = mod(sum(packets(1:packetSize,i)), 2); % obliczenie i dolaczenie bitu parzystosci 
    end
end