%{
symulacja przeslania danych przez kanal BSC - kazdy bit 
moze zostac przeklamany z prawdopodobienstwem probability. 
zostaje wykorzystana tutaj oficjalna biblioteka Communication Toolbox
%}
function sentData = sendDataThroughBSC(data, probability)
    sentData = bsc(data, probability);
end