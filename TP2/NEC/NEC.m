IMAGE_PATH = '../Media/lena.ppm';
[image, width, height] = readImage(IMAGE_PATH);
redChannel = getRedChannel(image);
redChannelDCT = dct2(redChannel);
[redChannelNEC, NECcoefficients] = applyNECOnChannel(redChannelDCT, width, height);
redChannel = cast(idct2(redChannelNEC), 'uint8');
image = setRedChannel(image, redChannel);
imwrite(image, '../Media/NEC_output.bmp');

function [image, width, height] = readImage(path)
    image = imread(path);
    [width, height, colors] = size(image);
end

function [redChannel] = getRedChannel(image)
    [width, height, colors] = size(image);
    for x = 1:width
        for y = 1:height
            redChannel(x,y) = image(x, y, 1);
        end
    end
end

function [image] = setRedChannel(image, redChannel)
    [width, height, colors] = size(image);
    for x = 1:width
        for y = 1:height
            image(x, y, 1) = redChannel(x, y);
        end
    end
end

function [NECChannel, coefficients] = applyNECOnChannel(channel, width, height)
    w = rand(width, height);
    for x = 1:width
        for y = 1:height
            if (w(x,y) > 0.8)
                coefficients(x,y) = (1 + 0.1 * w(x,y));
                
            else
                coefficients(x,y) = 1;
            end
            NECChannel(x,y) = channel(x,y) * coefficients(x,y);
        end
    end
end