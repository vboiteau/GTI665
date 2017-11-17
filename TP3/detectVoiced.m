function isVoiced = detectVoiced(chunk)
    passesTroughZero = 0;
    for sampleIndex = 1:179
        sampleProduct = chunk(sampleIndex) * chunk(sampleIndex+1);
        passTroughZero = sampleProduct < 0;
        if passTroughZero
            passesTroughZero = passesTroughZero + 1;
        end
    end
    zcr = passesTroughZero / 180;
    isVoiced = zcr < 0.1;
    disp([zcr passesTroughZero isVoiced]);
end