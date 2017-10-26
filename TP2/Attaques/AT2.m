path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Media/lena.ppm', basePath);
mkdir(sprintf('%s/../Media/output/attaques/AT2', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/AT2/lena.bmp', basePath);
original = imread(INPUT_PATH);
imageNoise = imnoise(original, 'salt & pepper', 0.1);
imwrite(imageNoise, OUTPUT_PATH);