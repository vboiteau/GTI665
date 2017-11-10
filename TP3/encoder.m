input = './Medias/wav/man.wav';
%input = './Medias/wav/woman.wav';
info = audioinfo(input);
signal = audioread(input);
chunks = splitSignal(signal);
for i = 1:length(chunks)
    chunk = chunks(i);
    isSilence = detectSilence(chunk);
end