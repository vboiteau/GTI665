getPhoneNumberByIndex(1);
getPhoneNumberByIndex(2);
getPhoneNumberByIndex(3);
getPhoneNumberByIndex(4);
getPhoneNumberByIndex(5);

function [phoneNumber] = getPhoneNumberByIndex(index)
    [signal, frequence] = audioread(sprintf('numeros_mysteres/numero_mystere%d.wav', index));
    valid = 1;
    for echantillonsParBloc = [640, 512, 320, 256, 192, 128, 96, 64, 32, 16, 8, 4, 2]
        blocsParSeconde = frequence / echantillonsParBloc;
        phoneNumber = getPhoneNumberFromSignal(signal, echantillonsParBloc, blocsParSeconde);
        if echantillonsParBloc == 256
            valid = 0;
        end
        if length(phoneNumber) == 10
            break;
        end
    end

    % log %
    fprintf('phoneNumber%d', index);
    disp(phoneNumber);
    if valid && length(phoneNumber) == 10
        disp('valid')
    else
        disp('invalid')
    end

    % spectogram %
    figure(index), specgram(signal, echantillonsParBloc, frequence), title(sprintf('Spectogramme pour le numéro de téléphone %d', index));
end

function [phoneNumber] = getPhoneNumberFromSignal(signal, echantillonsParBloc, blocsParSeconde)
    touches = {'1', '2', '3', 'A'; '4', '5', '6', 'B'; '7', '8', '9', 'C'; '*', '0', '#', 'D'};
    lowPks = []
    highPks = []
    for sectionIndex = 0:floor(length(signal)/echantillonsParBloc)
        sectionStart = max(sectionIndex*echantillonsParBloc, 1);
        sectionEnd = min((sectionIndex+1)*echantillonsParBloc, length(signal));
        [lowPk, highPk] = find2Pk(abs(fft(signal(sectionStart:sectionEnd))), blocsParSeconde);
        lowPks = [lowPks, lowPk];
        highPks = [highPks, highPk];
    end


    touchesLowFrequences = findTouchesPks(lowPks);
    touchesHighFrequences = findTouchesPks(highPks);

    phoneNumber = [];
    for toucheIndex = 1:length(touchesLowFrequences)
        lowIndex = getFrequenceIndex([697, 770, 852, 941], touchesLowFrequences{toucheIndex}, blocsParSeconde);
        highIndex = getFrequenceIndex([1209, 1336, 1477, 1633], touchesHighFrequences{toucheIndex}, blocsParSeconde);
        if lowIndex && highIndex
            foundedTouche = touches(lowIndex, highIndex);
            phoneNumber = [phoneNumber, touches(lowIndex,highIndex)];
        else
            disp('Invalid key')
        end
    end
end

function [lowPk, highPk] = find2Pk(section, blocsParSeconde)
    [~, pksLoc] = findpeaks(section);
    if length(pksLoc) > 0
        lowPk = (pksLoc(1)-1)*blocsParSeconde;
    else
        lowPk = 0;
    end
    if length(pksLoc) > 1
        highPk = (pksLoc(2)-1)*blocsParSeconde;
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
        touchesPks{k1} = mode(pks(ix0(k1):ix1(k1)));
    end
end

function [index] = getFrequenceIndex(frequences, frequence, blocsParSeconde)
    [c, index] = min(abs(frequences-frequence));
    if c > blocsParSeconde
        index = 0;
    end
end