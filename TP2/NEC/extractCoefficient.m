getWAsterix('../Media/output/attaques/AT2/NEC_output.bmp');
function w_asterix = getWAsterix(path)
    yi = imread(path);
    xi = dlmread('../Media/x.txt');
    [width, height, colors] = size(yi);
    redChannelDCT = dct2(getRedChannel(yi));
    wi = dlmread('../Media/w.txt');
    for x = 1:20
        for y = 1:20
            w_asterix(x,y) = (redChannelDCT(x,y) - xi(x,y))/(0.1*xi(x,y));
        end
    end
    sim = abs(conv2(wi, w_asterix))/sqrt(abs(conv2(w_asterix, w_asterix)));
    disp(mean2(sim));
end

function redChannel = getRedChannel(image)
    [width, height, colors] = size(image);
    for x = 1:width
        for y = 1:height
            redChannel(x,y) = image(x, y, 1);
        end
    end
end