function sentData = sendDataThroughGilbert(data, goodToBad, badToGood)
[packetSize, packetAmount] = size(data);

currentState = 0;

    for i =1:packetAmount          % przechodzi po kolumnach
        
        for j = 1 : packetSize             % przechodzi po wierszach
            currentState = flipState(currentState, goodToBad, badToGood);
            sentData(j,i) = xor(currentState, data(j,i));
        end
    end
end
 