path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Media/lena.ppm', basePath);
mkdir(sprintf('%s/../Media/output/attaques/AT1', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/AT1/lena.jpg', basePath);
original = imread(INPUT_PATH);
imwrite(original, OUTPUT_PATH, 'Quality', 10);