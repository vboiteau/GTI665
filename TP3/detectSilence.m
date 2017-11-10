function isSilence = detectSilence(chunk)
    averagePower = sum(chunk.^2)/180;
    isSilence = averagePower <= 0.000001;
    if(~isSilence)
        disp(averagePower)
    end
end