path_array = strsplit(mfilename('fullpath'), '/');
basePath = strjoin(path_array(1:length(path_array) - 1), '/');
INPUT_PATH = sprintf('%s/../Media/spatial_output3.bmp', basePath);
mkdir(sprintf('%s/../Media/output/attaques/AT1', basePath));
mkdir(sprintf('%s/../Media/tmp/', basePath));
OUTPUT_PATH = sprintf('%s/../Media/output/attaques/AT1/spatial_ouput3.jpg', basePath);
original = imread(INPUT_PATH);
imwrite(original, OUTPUT_PATH, 'Quality', 50);