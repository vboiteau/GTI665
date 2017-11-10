path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Patchwork/patchwork.ppm', basePath);
mkdir(sprintf('%s/../Media/output/attaques/patchwork/AT2', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/patchwork/AT2/patchworkAT2.bmp', basePath);
original = imread(INPUT_PATH);
imageNoise = imnoise(original, 'salt & pepper', 0.02);
imwrite(imageNoise, OUTPUT_PATH);
