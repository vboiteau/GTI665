imageOriginale = imread('Media/lena.ppm');
imageYCbCr=rgb2ycbcr(imageOriginale);
figure(1), imshow(imageOriginale);

%Max Value
n = 256;
%Matrix Length
l = 256;
randMatAx = randperm(n,l);
randMatAy = randperm(n,l);
randMatBx = randperm(n,l);
randMatBy = randperm(n,l);

TattooKey(:,1) = randMatAx;
TattooKey(:,2) = randMatAy;
TattooKey(:,3) = randMatBx;
TattooKey(:,4) = randMatBy;

Delta=1;
iteration = 10000;
for i=1:100
    if iteration == 0
            break
    end
    iteration = iteration - 1;
    
    for j=1:256
       if iteration == 0
            break
        end
       imageYCbCr(TattooKey(i,1),TattooKey(j,2)) = imageYCbCr(TattooKey(i,1),TattooKey(j,2)) + (Delta);
       imageYCbCr(TattooKey(i,3),TattooKey(j,4)) = imageYCbCr(TattooKey(i,3),TattooKey(j,4)) - (Delta);
       iteration = iteration - 1;
    end
end

imageTatouee=ycbcr2rgb(imageYCbCr);
figure(2), imshow(imageTatouee);

iteration = 10000;
for i=1:100
    if iteration == 0
            break
    end
    iteration = iteration - 1;
    
    for j=1:256
       if iteration == 0
            break
        end
       imageYCbCr(TattooKey(i,1),TattooKey(j,2)) = imageYCbCr(TattooKey(i,1),TattooKey(j,2)) - (Delta);
       imageYCbCr(TattooKey(i,3),TattooKey(j,4)) = imageYCbCr(TattooKey(i,3),TattooKey(j,4)) + (Delta);
       iteration = iteration - 1;
    end
end

imageExtraction=ycbcr2rgb(imageYCbCr);
figure(3), imshow(imageExtraction);

