input = './Medias/wav/man.wav';
%input = './Medias/wav/woman.wav';
info = audioinfo(input);
signal = audioread(input);
chunks = splitSignal(signal);
window = hamming(180);
%disp("Chunks: "+length(chunks));

fileID = fopen('man.LPC','w');

doit = 1;
for i = 1:length(chunks)
    chunk = chunks(i,:);
    isSilence = detectSilence(chunk);
    if isSilence == 0
        isVoiced = detectVoiced(chunk);
        pitch = 0;
        if isVoiced
            [f0_time,f0_value,SHR,f0_candidates] = shrp(chunk,8000,[50 250],22.5,22.5,0.4,1250,0,0);
            pitch = f0_value;
        end
        
        weightedChunk = chunk.*transpose(window);
            
        filteredChunk = conv(weightedChunk,1-0.9375);

        [AR,E,K] = lpcauto(filteredChunk,10,180);
        gain = sqrt(E);
        c = AR(2:length(AR));
        
        fprintf(fileID,'%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.9f,%d,%3.2f\n',c(1),c(2),c(3),c(4),c(5),c(6),c(7),c(8),c(9),c(10),gain,isVoiced,pitch);
        
%         if doit 
%             wvtool(chunk)
%             wvtool(window);
%             wvtool(weightedChunk);
%             wvtool(filteredChunk);
%         end
        doit = 0;
    else
        fprintf(fileID,'0,0,0,0,0,0,0,0,0,0,0,0,0\n');
    end
 
end

fopen(fileID);