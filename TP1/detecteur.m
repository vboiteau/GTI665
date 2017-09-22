[signal1] = audioread('numeros_mysteres/numero_mystere1.wav');
phoneNumber1 = getPhoneNumberFromSignal(signal1);
fprintf('phoneNumber1');
disp(phoneNumber1);

[signal2] = audioread('numeros_mysteres/numero_mystere2.wav');
phoneNumber2 = getPhoneNumberFromSignal(signal2);

fprintf('phoneNumber2');
disp(phoneNumber2);

[signal3] = audioread('numeros_mysteres/numero_mystere3.wav');
phoneNumber3 = getPhoneNumberFromSignal(signal3);

fprintf('phoneNumber3');
disp(phoneNumber3);

function [phoneNumber] = getPhoneNumberFromSignal(signal)
    touches = {'1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*', '0', '#', 'D'};
    lowPks = []
    highPks = []
    for sectionIndex = 0:floor(length(signal)/512)
        sectionStart = max(sectionIndex*512, 1);
        sectionEnd = min((sectionIndex+1)*512, length(signal));
        [lowPk, highPk] = find2Pk(abs(fft(signal(sectionStart:sectionEnd))));
        lowPks = [lowPks, lowPk];
        highPks = [highPks, highPk];
    end


    touchesLowFrequences = findTouchesPks(lowPks);
    touchesHighFrequences = findTouchesPks(highPks);

    phoneNumber = [];
    for toucheIndex = 1:length(touchesLowFrequences)
        lowIndex = getFrequenceIndex([697, 770, 852, 941], touchesLowFrequences{toucheIndex});
        highIndex = getFrequenceIndex([1209, 1336, 1477, 1633], touchesHighFrequences{toucheIndex});
        phoneNumber = [phoneNumber, touches(lowIndex,highIndex)];
    end
end

function [lowPk, highPk] = find2Pk(section)
    [~, pksLoc] = findpeaks(section);
    if length(pksLoc) > 0
        lowPk = (pksLoc(1)-1)*15.625;
    else
        lowPk = 0;
    end
    if length(pksLoc) > 1
        highPk = (pksLoc(2)-1)*15.625;
    else
        highPk = 0;
    end
end

function [touchesPks] = findTouchesPks(pks)
    % https://www.mathworks.com/matlabcentral/answers/156650-splitting-a-vector-up-into-unequal-sections-seperated-by-zeros?requestedDomain=www.mathworks.com
    ne0 = find(pks~=0);
    ix0 = unique([ne0(1) ne0(diff([0 ne0])>1)]);
    ix1 = ne0([find(diff([0 ne0])>1)-1 length(ne0)]);
    touchesPks = [];
    for k1 = 1:length(ix0)
        touchesPks{k1} = max(pks(ix0(k1):ix1(k1)));
    end
end

function [index] = getFrequenceIndex(frequences, frequence)
    [c, index] = min(abs(frequences-frequence));
    if c > 15.625
        index = 0;
    end
end