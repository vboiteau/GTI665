extractTatooFromImage('../Media/output/attaques/AT4/spatial_output3.bmp', '../Media/output/spatialTatoos/AT4.txt', 3);
 
function extractTatooFromImage(path, tatooPath, nbBits)
    tatooFileId = fopen(tatooPath, 'w');
    original = imread(path);
    [width, height, colors] = size(original);
    for x = 1:width
        for y = 1:height
            for color = 1:colors
                originalByte = original(x, y, color);
                extractedByte = extractTatooBits(originalByte, nbBits);
                fprintf(tatooFileId, '%d\n', extractedByte);
            end
        end
    end
    fclose(tatooFileId);
end

function extractedByte = extractTatooBits(byte, nbBits)
    bits = bitget(byte, 8:-1:1);
    extractedBits = bitget(0, 8:-1:1);
    extractedBits = [extractedBits(1:8-nbBits) bits(9-nbBits:8)];
    extractedByte = bi2de(extractedBits, 'left-msb');
end