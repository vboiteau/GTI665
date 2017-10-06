[Lena, xLena] = imread('Media/lena.ppm');
[Tatou, xTatou] = imread('Media/ETS1.bmp');
for y = 1:length(Lena)
    yTatou = mod(y,length(Tatou)) + 1;
    for x = 1:length(Lena(:,y))/3
        xTatou = mod(x, length(Tatou(:,yTatou))/3) + 1;
        fprintf('xLe\tyLe\txTa\tyTa\n%d\t%d\t%d\t%d\n\n', x, y, xTatou, yTatou);
    end
end