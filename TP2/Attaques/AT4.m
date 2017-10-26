path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Media/lena.ppm', basePath);
mkdir(sprintf('%s/../Media/output/attaques/AT4', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/AT4/lena.bmp', basePath);
original = imread(INPUT_PATH);
[width, height, color] = size(image);
newWidth = width * 0.75;
newHeight = height * 0.75;
newX = (width - newWidth) / 2;
newY = (height - newHeight) / 2;
imageCropped = imcrop(original, [newX newY (newX + newWidth) (newY + newHeight)]);
imwrite(imageCropped, OUTPUT_PATH);