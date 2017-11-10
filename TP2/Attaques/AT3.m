path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Patchwork/patchwork.ppm', basePath);
mkdir(sprintf('%s/../Media/output/attaques/patchwork/AT3', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/patchwork/AT3/patchworkAT3.bmp', basePath);
original = imread(INPUT_PATH);
imageRot = imrotate(original, 90);
imwrite(imageRot, OUTPUT_PATH);
