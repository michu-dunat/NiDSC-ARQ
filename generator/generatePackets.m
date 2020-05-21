%{ 
generowana jest tablica o wymiarach: packetAmount - ilosc kolumn, 
packetSize - ilosc wierszy, jeden pakiet = jedna kolumna
%}  
function packets = generatePackets(packetSize, packetAmount)
    packets = randi([0, 1], packetSize, packetAmount); 
end