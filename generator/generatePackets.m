%{ 
generowana jest tablica o wymiarach: packetAmount - ilosc kolumn, 
packetSize - ilosc wierszy, jeden pakiet = jedna kolumna
%}  
function packets = generatePackets(packetAmount, packetSize)
    packets = randi([0, 1], packetSize, packetAmount); 
end