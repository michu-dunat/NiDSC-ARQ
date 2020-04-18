function nextState = flipState(currentState, goodToBad, badToGood)

    if currentState == 0   % jesli dobry
        nextState = rand(1) < goodToBad;
    elseif currentState == 1
        nextState = rand(1) > badToGood;
    end

end
