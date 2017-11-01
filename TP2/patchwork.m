%Loder l'image (RGB)
imageLena = imread('Media/lena.ppm');

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
figure(4), imshow(imageTatouee);

Sn2 = 0;
for i=1:10000
   diff = double(imageTatoueeHSV(keyAx(i),keyAy(i),3)) - double(imageTatoueeHSV(keyBx(i),keyBy(i),3));
   Sn2 = Sn2 + diff;
end
Sn2 = round(Sn2*256);
fprintf('Sn image tatouee %i\n', Sn2);
%disp(std2(imageTatouee));
%disp(mean2(imageTatouee));

for i=1:10000   
   imageHSV(keyAx(i),keyAy(i),3) = imageHSV(keyAx(i),keyAy(i),3) - Delta;
   imageHSV(keyBx(i),keyBy(i),3) = imageHSV(keyBx(i),keyBy(i),3) + Delta;
end

finalImgExtraction=hsv2rgb(imageHSV);
figure(5), imshow(finalImgExtraction);
%disp(std2(finalImgExtraction));
%disp(mean2(finalImgExtraction));