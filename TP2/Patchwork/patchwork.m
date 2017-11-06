%Loder l'image (RGB)
imageLena = imread('../Media/lena.ppm');

%Transformer l'image en HSV (pour alterer la luminence)
imageHSV=rgb2hsv(imageLena);

%Generation des couples avec le seed 3
[width, height, elms] = size(imageHSV);
[keyAx,keyAy,keyBx,keyBy] = secretGenerator(3,width,height);

Sn1 = 0;
for i=1:10000
   diff = double(imageHSV(keyAx(i),keyAy(i),3)) - double(imageHSV(keyBx(i),keyBy(i),3));
   Sn1 = Sn1 + diff;
end
Sn1 = round(Sn1*256);
fprintf('Sn image originale %i\n', Sn1);

%Applicaiton de patchwork
Delta=5 / 256;
for i=1:10000   
   imageHSV(keyAx(i),keyAy(i),3) = imageHSV(keyAx(i),keyAy(i),3) + Delta;
   imageHSV(keyBx(i),keyBy(i),3) = imageHSV(keyBx(i),keyBy(i),3) - Delta;
end

imageTatouee=hsv2rgb(imageHSV);
imageTatoueeHSV=imageHSV;
imwrite(imageTatouee,'patchwork.ppm');
figure(1), imshow(imageTatouee);

Sn2 = 0;
for i=1:10000
   diff = double(imageTatoueeHSV(keyAx(i),keyAy(i),3)) - double(imageTatoueeHSV(keyBx(i),keyBy(i),3));
   Sn2 = Sn2 + diff;
end
Sn2 = round(Sn2*256);
fprintf('Sn image tatouee %i\n', Sn2);

AT1(imageTatouee);
AT2(imageTatouee);
AT3(imageTatouee);
AT4(imageTatouee);

function AT1(image)
    imwrite(image, 'attaque1.jpg', 'Quality', 10);
    
    attaque = imread('attaque1.jpg');
    attaqueHSV=rgb2hsv(attaque);
    
    [width, height, page] = size(attaqueHSV);
    [keyAx,keyAy,keyBx,keyBy] = secretGenerator(3,width,height);
    
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT1: %i\n', Sn);
end

function AT2(image)
    imageNoise = imnoise(image, 'salt & pepper', 0.1);
    imwrite(imageNoise, 'attaque2.jpg');
    
    attaque = imread('attaque2.jpg');
    attaqueHSV=rgb2hsv(attaque);
    
    [width, height, page] = size(attaqueHSV);
    [keyAx,keyAy,keyBx,keyBy] = secretGenerator(3,width,height);
    
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT2: %i\n', Sn);
end

function AT3(image)
    imageRot = imrotate(image, 90);
    imwrite(imageRot, 'attaque3.jpg');
    
    attaque = imread('attaque3.jpg');
    attaqueHSV=rgb2hsv(attaque);
    
    [width, height, page] = size(attaqueHSV);
    [keyAx,keyAy,keyBx,keyBy] = secretGenerator(3,width,height);
    
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT3: %i\n', Sn);
end

function AT4(image)
    
    [width, height, color] = size(image);
    newWidth = width * 0.75;
    newHeight = height * 0.75;
    newX = (width - newWidth) / 2;
    newY = (height - newHeight) / 2;
    imageCropped = imcrop(image, [newX newY (newX + newWidth) (newY + newHeight)]);
    imwrite(imageCropped, 'attaque4.jpg');
    
    attaque = imread('attaque4.jpg');
    attaqueHSV=rgb2hsv(attaque);
    
    [width, height, page] = size(attaqueHSV);
    [keyAx,keyAy,keyBx,keyBy] = secretGenerator(3,width,height);
    
    Sn = 0;
    for i=1:10000
       diff = double(attaqueHSV(keyAx(i),keyAy(i),3)) - double(attaqueHSV(keyBx(i),keyBy(i),3));
       Sn = Sn + diff;
    end
    Sn = round(Sn*256);
    fprintf('Sn image tatouee AT4: %i\n', Sn);
    
end

function [keyAx,keyAy,keyBx,keyBy] = secretGenerator(seed,width,height)
    
    rng('default');
    rng(seed);
    s=rand(width,height);

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
end