clear;
finalsignal = [];
CSV_FILE = 'man.LPC';
chunks = csvread(CSV_FILE);
firsttime = 1;
%finalsignal = zeros(1,length(chunks)*90);
for chunkIndex = 1:length(chunks)
    c = chunks(chunkIndex, 1:10);
    gain = chunks(chunkIndex, 11);
    isVoiced = chunks(chunkIndex, 12);
    pitch = chunks(chunkIndex, 13);
    
    if isVoiced
        
        t=1:1:180;
        d=1:round(180/(pitch/(8000/180))):180;
        y = pulstran(t,d,'rectpuls',1/180);
    %    figure(1);stem(y);
     %   pitch
      %  waitforbuttonpress
    else    
        y=randn(1,180);
    end
    
    coeffs = [1,c(1),c(2),c(3),c(4),c(5),c(6),c(7),c(8),c(9),c(10)];
    filteredChunk = filter(gain,coeffs,y);
    
    weightedChunk = conv(filteredChunk,[1,0.9375]);
    
    if chunkIndex == 1
        stem(y);
        plot(filteredChunk);
        plot(weightedChunk);
    end
    
    %finalsignal(chunkIndex*90-89:chunkIndex*90) = weightedChunk(1:90);
    %finalsignal(chunkIndex*90-89:chunkIndex*90) = weightedChunk(1:90);
finalsignal = [finalsignal weightedChunk(1:90)];
end

audiowrite('decoded.wav',finalsignal,8000,'BitsPerSample',16);
