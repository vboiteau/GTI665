
% fréquence d'échantillonnage (en Hz) de la séquence audio.
f1=8000;
% durée d'une touche (en seconde).
d=0.2;
% création des fonctions qui serviront à construire le signal audio.
t=0:f1*d;
s1= (sin(2*pi*697/f1*t)+sin(2*pi*1209/f1*t))/2;
s2= (sin(2*pi*697/f1*t)+sin(2*pi*1336/f1*t))/2;
s3= (sin(2*pi*697/f1*t)+sin(2*pi*1477/f1*t))/2;
s4= (sin(2*pi*770/f1*t)+sin(2*pi*1209/f1*t))/2;
s5= (sin(2*pi*770/f1*t)+sin(2*pi*1336/f1*t))/2;
s6= (sin(2*pi*770/f1*t)+sin(2*pi*1477/f1*t))/2;
s7= (sin(2*pi*852/f1*t)+sin(2*pi*1209/f1*t))/2;
s8= (sin(2*pi*852/f1*t)+sin(2*pi*1336/f1*t))/2;
s9= (sin(2*pi*852/f1*t)+sin(2*pi*1477/f1*t))/2;
s0= (sin(2*pi*941/f1*t)+sin(2*pi*1336/f1*t))/2;
ss= 0*t;
t=0:f1*0.1;
sc= 0*t;
% Concaténation de plusieurs fonctions pour créer le signal résultant.
signal = [s3 sc s4 sc s5 ss s6 sc s7 sc s8 ss s7 sc s6 sc s0 sc s0 sc];
figure(1),plot(signal), title('Signal audio');
figure(2),specgram(signal, 512, f1),title('Spectrogramme');
signalb = [s4 sc s3 sc s2 ss s9 sc s8 sc s7 sc s6 sc];
figure(2),specgram(signalb, 512, f1),title('Spectrogramme Signal 432-9876');
audiowrite('4329876.wav',signalb,f1);