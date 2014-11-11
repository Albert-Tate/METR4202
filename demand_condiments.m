function [  ] = demand_condiments(coffee, tea, sugar, espresso)
    %Outputs vibrations from the user device that happen to make words.
    %   Takes the number of required coffee, tea, sugar and espresso
    %   sachets required for the drink and asks for them to be added.
    
    clc
    
    %% Initial Pun
    puns = {'I will complete this order by any beans necessary', 'Thanks a latte!','Back to the daily grind', 'That was a brewed awakening'};
    i = randi(length(puns));

    tts(char(puns(i)));
    %% Coffee
    switch coffee
        case 1
            tts('One coffee');
        case 2
            tts('Two coffees');
    end
    
    %% Tea
    switch tea
        case 1
            tts('One tea');
        case 2
            tts('Two teas');
    end
    
    %% Sugar
    switch sugar
        case 1
            tts('One sugar');
        case 2
            tts('Two sugars');
        case 3
            tts('Sugar times threes, for diabetes');
        otherwise
            tts('No sugar, Overlord Singh is sweet enough already');
    end
    
        %% Tea
    switch espresso
        case 1
            tts('An expresso espresso please. Thank you');
        otherwise
            tts('Thank you');
    end
    
    
end

