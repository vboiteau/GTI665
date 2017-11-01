%Loder l'image (RGB)
imageLena = imread('../Media/lena.ppm');

%Transformer l'image en HSV (pour alterer la luminence)
imageHSV=rgb2hsv(imageLena);

figure(1), imshow(imageLena);
%figure(2), imshow(LenaHSV);

[height, width, elms] = size(imageHSV);

rng(1);
s=rand(1,60000);

keyAx = [];
keyAy = [];
keyBx = [];
keyBy = [];

for i=1:10000
   ax=round((width-1)*s((i*5)-3)) + 1;
   ay=round((height-1)*s((i*5)-2)) + 1;
   bx=round((width-1)*s((i*5)-1)) + 1;
   by=round((height-1)*s((i*5))) + 1;
   
   keyAx(i) = ax;
   keyAy(i) = ay;
   keyBx(i) = bx;
   keyBy(i) = by;
end

Sn1 = 0;
for i=1:10000
   diff = double(imageHSV(keyAx(i),keyAy(i),3)) - double(imageHSV(keyBx(i),keyBy(i),3));
   Sn1 = Sn1 + diff;
end
Sn1 = round(Sn1*256);
fprintf('Sn image originale %i\n', Sn1);
%disp(std2(imageLena));
%disp(mean2(imageLena));

%Applicaiton de patchwork
Delta=5 / 256;
for i=1:10000   
   imageHSV(keyAx(i),keyAy(i),3) = imageHSV(keyAx(i),keyAy(i),3) + Delta;
   imageHSV(keyBx(i),keyBy(i),3) = imageHSV(keyBx(i),keyBy(i),3) - Delta;
end

imageTatouee=hsv2rgb(imageHSV);
imageTatoueeHSV=imageHSV;
imwrite(imageTatouee,'patchwork.ppm');
figure(4), imshow(imageTatouee);

Sn2 = 0;
for i=1:10000
   diff = double(imageTatoueeHSV(keyAx(i),keyAy(i),3)) - double(imageTatoueeHSV(keyBx(i),keyBy(i),3));
   Sn2 = Sn2 + diff;
end
Sn2 = round(Sn2*256);
fprintf('Sn image tatouee %i\n', Sn2);

AT1(imageTatouee,keyAx,keyAy,keyBx,keyBy);
AT2(imageTatouee,keyAx,keyAy,keyBx,keyBy);
AT3(imageTatouee,keyAx,keyAy,keyBx,keyBy);
%AT4(imageTatouee,keyAx,keyAy,keyBx,keyBy); Marche pas car les index ne
%sont plus les memes (la dimension a change)

function AT1(image,keyAx,keyAy,keyBx,keyBy)
    imwrite(image, 'attaque1.jpg', 'Quality', 10);
    attaque = imread('attaque1.jpg');
    attaqueHSV=rgb2hsv(attaque);
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT1: %i\n', Sn);
end

function AT2(image,keyAx,keyAy,keyBx,keyBy)
    imageNoise = imnoise(image, 'salt & pepper', 0.1);
    imwrite(imageNoise, 'attaque2.jpg');
    
    attaque = imread('attaque2.jpg');
    attaqueHSV=rgb2hsv(attaque);
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT2: %i\n', Sn);
end

function AT3(image,keyAx,keyAy,keyBx,keyBy)
    imageRot = imrotate(image, 90);
    imwrite(imageRot, 'attaque3.jpg');
    
    attaque = imread('attaque3.jpg');
    attaqueHSV=rgb2hsv(attaque);
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT3: %i\n', Sn);
end

function AT4(image,keyAx,keyAy,keyBx,keyBy)
    
    [width, height, color] = size(image);
    newWidth = width * 0.75;
    newHeight = height * 0.75;
    newX = (width - newWidth) / 2;
    newY = (height - newHeight) / 2;
    imageCropped = imcrop(image, [newX newY (newX + newWidth) (newY + newHeight)]);
    imwrite(imageCropped, 'attaque4.jpg');
    
    attaque = imread('attaque4.jpg');
    attaqueHSV=rgb2hsv(attaque);
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT4: %i\n', Sn);
    
end

%disp(std2(imageTatouee));
%disp(mean2(imageTatouee));

%for i=1:10000   
%   imageHSV(keyAx(i),keyAy(i),3) = imageHSV(keyAx(i),keyAy(i),3) - Delta;
%   imageHSV(keyBx(i),keyBy(i),3) = imageHSV(keyBx(i),keyBy(i),3) + Delta;
%end

%finalImgExtraction=hsv2rgb(imageHSV);
%figure(5), imshow(finalImgExtraction);
%disp(std2(finalImgExtraction));
%disp(mean2(finalImgExtraction));