# NiDSC-ARQ
Projekt studencki z przedmiotu Niezawodność i diagnostyka systemów cyfrowych 2
## Opis wybranych części symulatora
### Generowanie pakietów
Generowanie pakietów odbywa się z wykorzystaniem funkcji ``` randi() ```. Można wygenerować dowolną ilość pakietów o wybranym rozmiarze.
### Kody detekcyjne
Dane można zakodować przy pomocy następujących kodów detekcyjnych:
- Bit parzystości.
- CRC-32.

Bit parzystości został samodzielnie zaimplementowany (0 oznacza parzystą ilość jedynek, 1 oznacza nieparzystą ilość jedynek). 

Do implementacji CRC-32 użyto biblioteki ``` Communication Toolbox ```, a dokładniej funkcji ``` comm.CRCGenerator() ``` i ``` comm.CRCDetector() ```.
### Kanały transmisyjne
Dane można wysłać następującymi kanałami transmisyjnymi:
- Binary Symmetric Channel (BSC).
- Model Gilberta.

BSC został zaimplementowany z wykorzystaniem biblioteki ``` Communication Toolbox ```, a dokładniej użyto funkcji ``` bsc() ```.

Kanał Gilberta zaimplementowano samodzielnie. Kanał może znajdować się w dwóch stanach - dobrym i złym. 
Opisują go dwa prawdopodobieństwa - przejścia z dobrego stanu do złego (bardzo małe prawdopodobieństwo) 
i vice versa (bardzo duże prawdopodobieństwo).
Jeżeli kanał znajduje się w stanie dobrym to przesyłane są poprawne bity z prawdopodobieństwem ``` 1 - pierwsze prawdopodobieństwo ```, 
a jeżeli kanał znajduje się w stanie złym to przesyłane są niepoprawne bity z prawdopodobieństwem drugim.
### Protokół ARQ
Użyto najprostszego protokołu ARQ - Stop-and-wait. Pakiety wysyłane są pojedynczo; jeżeli wykryto błąd następuje retransmisja do skutku.
## Przygotowanie do uruchomienia
Aby uruchomić symulator wymagane jest posiadanie środowiska [MATLAB](https://www.mathworks.com/products/matlab.html). Należy pobrać repozytorium np. używając poniższej komendy:
> \>git clone https://github.com/Denaturatus/NiDSC-ARQ.git
 
W celu uruchomienia symulatora należy napisać w linii komend MATLAB-a:
> \>>simulation
## Generowanie wyników
Plikiem odpowiedzialnym za przeprowadzanie eksperymentu jest plik: ``` simulation.m ```. Parametry symulacji można modyfikować zmieniając wartości następujących zmiennych:
```
packetAmount = 20;
packetSize = 30;
errorProbability = 0.05;
goodToBadProbability = 0.02;
badToGoodProbability = 0.8;
codingType = 'PB';  % 'CRC32' or 'PB'
channel = 'GILBERT'; % 'BSC' or 'GILBERT'
loopRepetitions = 100;
```
Domyślnie wyświetlanymi wynikami są BER jaką "widzi" użytkownik i całkowita nadmiarowość transmisji:
```
userBitErrorRateAvg = errorAmountAvg / nAvg;
transmissionRedundancyAvg = (redundantBitsFromCodingAvg + redundantBitsFromRetransmissionAvg)/ allBitsSentAvg;
disp(['BER uzytkownika: ', num2str(userBitErrorRateAvg)]);
disp(['Calkowita nadmiarowosc transmisji: ', num2str(transmissionRedundancyAvg)]);
```
Można wyświetlić dodatkowe wyniki odkomentowując następujące linijki kodu:
```
%{
disp(['Ilosc wyslanych pakietow: ', num2str(nAvg)]);
disp(['Ilosc pakietow z bledem: ', num2str(errorAmountAvg)]);
disp(['Wszystkie przeslane bity: ', num2str(allBitsSentAvg)]);
disp(['Nadmiarowe bity wynikające z retransmisji: ', num2str(redundantBitsFromRetransmissionAvg)]);
disp(['Nadmiarowe bity wynikające z kodowania: ', num2str(redundantBitsFromCodingAvg)]);
%}
```
## Autorzy projektu
- Michał Dunat
- Paweł Maciończyk
