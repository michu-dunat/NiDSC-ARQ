clear; 
clc;
% pokaz mozliwosci symulatora na dzien 20.06.2020

% parametry pomiaru
packetAmount = 20;
packetSize = 30;
errorProbability = 0.05;
goodToBadProbability = 0.02;
badToGoodProbability = 0.8;
codingType = 'PB';  % 'CRC32' or 'PB'
channel = 'GILBERT'; % 'BSC' or 'GILBERT'
loopRepetitions = 100;

% inicjalizacja zmiennych do usrednionych wynikow
errorAmountAvg = 0;
nAvg = 0;
allBitsSentAvg = 0;
redundantBitsFromCodingAvg = 0;
redundantBitsFromRetransmissionAvg = 0;

for j = 1 : loopRepetitions
    [errorAmount, n, allBitsSent, redundantBitsFromCoding, redundantBitsFromRetransmission, result] = stopAndWaitARQ(packetAmount, packetSize, errorProbability, goodToBadProbability, badToGoodProbability,codingType, channel);
    errorAmountAvg = errorAmountAvg + errorAmount;
    nAvg = nAvg + n;
    allBitsSentAvg = allBitsSentAvg + allBitsSent;
    redundantBitsFromCodingAvg = redundantBitsFromCodingAvg + redundantBitsFromCoding;
    redundantBitsFromRetransmissionAvg = redundantBitsFromRetransmissionAvg + redundantBitsFromRetransmission;
    disp([num2str(j * 100 / loopRepetitions), '%']);
end

% obliczanie srednich
errorAmountAvg = errorAmountAvg / loopRepetitions;
nAvg = nAvg / loopRepetitions;
allBitsSentAvg = allBitsSentAvg / loopRepetitions;
redundantBitsFromCodingAvg = redundantBitsFromCodingAvg / loopRepetitions;
redundantBitsFromRetransmissionAvg = redundantBitsFromRetransmissionAvg / loopRepetitions;

% wyswietlenie wynikow
%{
disp(['Ilosc wyslanych pakietow: ', num2str(nAvg)]);
disp(['Ilosc pakietow z bledem: ', num2str(errorAmountAvg)]);
disp(['Wszystkie przeslane bity: ', num2str(allBitsSentAvg)]);
disp(['Nadmiarowe bity wynikające z retransmisji: ', num2str(redundantBitsFromRetransmissionAvg)]);
disp(['Nadmiarowe bity wynikające z kodowania: ', num2str(redundantBitsFromCodingAvg)]);
%}

userBitErrorRateAvg = errorAmountAvg / nAvg;
transmissionRedundancyAvg = (redundantBitsFromCodingAvg + redundantBitsFromRetransmissionAvg)/ allBitsSentAvg;
disp(['BER uzytkownika: ', num2str(userBitErrorRateAvg)]);
disp(['Calkowita nadmiarowosc transmisji: ', num2str(transmissionRedundancyAvg)]);
