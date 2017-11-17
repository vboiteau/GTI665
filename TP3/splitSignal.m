function chunks = splitSignal(signal)
    chunkCount = ceil(length(signal)/90);
    chunks = zeros(chunkCount, 180);
    chunkCursor = 1;
    for signalCursor = 1:length(signal)
        chunkPosition = mod(signalCursor, 90) + 1;
        chunkIndex = ceil(signalCursor/90);
        chunks(chunkIndex, chunkPosition) = signal(signalCursor);
        if (chunkCursor ~= 1)
            chunks(chunkIndex - 1, 90 + chunkPosition) = signal(signalCursor);
        end
    end
end
