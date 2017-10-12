for nbBitToSwitch = 1:8
    tatooImage('Media/lena.ppm', 'Media/ETS1.bmp', sprintf('Media/output%d.bmp', nbBitToSwitch), nbBitToSwitch);
end
function TatooedImage = tatooImage(originalPath, tatooPath, tatooedPath, nbBitToSwitch)
    Original = imread(originalPath);
    originalSize = size(Original);
    originalWidth = originalSize(1);
    originalHeight = originalSize(2);
    Tatoo = imread(tatooPath);
    tatooSize = size(Tatoo);
    tatooWidth = tatooSize(1);
    tatooHeight = tatooSize(2);
    fprintf('Original:\t%d\t%d\nTatoo:\t%d\t%d\n\n', originalWidth, originalHeight, tatooWidth, tatooHeight);
    TatooedImage = Original;
    for y = 1:originalHeight
        yTatoo = mod(y,tatooHeight) + 1;
        for x = 1:originalWidth
            xTatoo = mod(x, tatooWidth) + 1;
            originalRed = Original(x, y, 1);
            originalGreen = Original(x, y, 2);
            originalBlue = Original(x, y, 3);
            tatooRed = Tatoo(xTatoo, yTatoo, 1);
            tatooGreen = Tatoo(xTatoo, yTatoo, 2);
            tatooBlue = Tatoo(xTatoo, yTatoo, 3);
            TatooedImage(x, y, 1) = tatooByte(originalRed, tatooRed, nbBitToSwitch);
            TatooedImage(x, y, 2) = tatooByte(originalGreen, tatooGreen, nbBitToSwitch);
            TatooedImage(x, y, 3) = tatooByte(originalBlue, tatooBlue, nbBitToSwitch);
        end
    end
    imwrite(TatooedImage, tatooedPath);
end

function tatooedByte = tatooByte(originalByte, tatooByte, nbBitToSwitch)
    
    originalBits = bitget(originalByte, 8:-1:1);
    tatooBits = bitget(tatooByte, 8:-1:1);
    tatooedBits = [originalBits(1:8-nbBitToSwitch) tatooBits(9-nbBitToSwitch:8)];
    tatooedByte = bi2de(tatooedBits, 'left-msb');
end