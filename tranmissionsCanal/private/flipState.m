%{
prywatna funkcja okreslajaca obecny stan
z podanymi prawdopodobienstwami moze nastapic zmiana stanu 
%}
function nextState = flipState(currentState, goodToBad, badToGood)
    if currentState == 0 % stan dobry - 0, stan zly - 1
        nextState = rand(1) < goodToBad;
    elseif currentState == 1
        nextState = rand(1) > badToGood;
    end
end