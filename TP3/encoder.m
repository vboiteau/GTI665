input = './Medias/wav/man.wav';
%input = './Medias/wav/woman.wav';
info = audioinfo(input);
signal = audioread(input);
chunks = splitSignal(signal);
disp("Chunks: "+length(chunks));
for i = 1:length(chunks)
    chunk = chunks(i,:);
    isSilence = detectSilence(chunk);
    if isSilence == 0
        isVoiced = detectVoiced(chunk);
        
        if isVoiced
            [f0_time,f0_value,SHR,f0_candidates] = shrp(chunk,8000,[50 250],22.5,10,0.4,1250,0,1)
            
        end
        
    end
end