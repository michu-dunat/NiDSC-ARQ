%{
symulacja przeslania danych przez kanal o modelu Gilberta-Eliota
kanal moze znajdowac sie w dwoch stanach - dobrym i zlym, 
kanal opisuja dwa prawdopobienstwa - przejscia z dobrego stanu do zlego 
(bardzo male prawdopodbienstwo) i ze zlego do dobrego (bardzo duze prawdopodbienstwo)
jezeli kanal znajduje sie w stanie dobrym to przesylane sa te same bity
jezeli kanal znajduje sie w stanie zlym to przesylane sa bity przeciwne
%}
function sentData = sendDataThroughGilbert(data, goodToBad, badToGood)
[packetSize, packetAmount] = size(data); % pobranie rozmiaru tablicy
currentState = 0; % stan dobry - 0, stan zly - 1
sentData = zeros(packetSize, packetAmount); 
    for i = 1 : packetAmount % przechodzenie po kolumnach
        for j = 1 : packetSize % przechodzenie po wierszach
            currentState = flipState(currentState, goodToBad, badToGood); % wywloanie funkcji okreslenia obecnego stanu
            if currentState == 0
                % przesylanie poprawnych bitow w stanie dobrym z prawdopodobienstwem (1-goodToBad)
                sentData(j,i) = xor(data(j,i), (rand(1) < goodToBad)); 
            elseif currentState == 1
                % przesylanie niepoprawnych bitow w stanie zlym z prawdopodobienstwem badToGood
                sentData(j,i) = xor(data(j,i), (rand(1) < badToGood)); 
            end   
        end
    end
end
 