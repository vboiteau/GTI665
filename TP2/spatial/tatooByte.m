function tatooedByte = tatooByte(originalByte, tatooByte, nbBitToSwitch)
    originalBits = bitget(originalByte, 8:-1:1);
    tatooBits = bitget(tatooByte, 8:-1:1);
    tatooedBits = [originalBits(1:8-nbBitToSwitch) tatooBits(9-nbBitToSwitch:8)];
    tatooedByte = bi2de(tatooedBits, 'left-msb');
end
