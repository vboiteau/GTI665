input = './Medias/wav/man.wav';
%input = './Medias/wav/woman.wav';
info = audioinfo(input)
signal = audioread(input);
chunks = splitSignal(signal);
disp(length(chunks))
for i = 1:length(chunks)
    chunk = chunks(i,:);
    isSilence = detectSilence(chunk);
    if isSilence
        isVoiced = detectVoiced(chunk);
    end
end