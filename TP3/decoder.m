CSV_FILE = 'man.LPC';
chunks = csvread(CSV_FILE);
for chunkIndex = 1:length(chunks)
    c = chunks(chunkIndex, 1:10);
    gain = chunks(chunkIndex, 11);
    isVoiced = chunks(chunkIndex, 12);
    pitch = chunks(chunkIndex, 13);
end