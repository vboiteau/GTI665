% Documentation Matlab Butterworth Filter:
% https://www.mathworks.com/help/signal/ref/butter.html

% FICHIER MYSTERE 1
[s1,F1] = audioread('media/mystere1.wav');
% Figure 1 Mystere 1 - Fichier Entier
figure(1),plot(s1), title('Mystere 1 - Fichier entier');
% Figure 2 Mystere 1 - Seconde du Signal
figure(2),plot(s1), title('Mystere 1 - Premiere Seconde');
xlim([0 F1]);
% Figure 3 Mystere 1 - Spectrogramme
figure(3),specgram(s1, 512, F1), title('Mystere 1 - Spectrogramme');

% Mystere 1 - Filtre 
fc = 1300;
% Design a Butterworth filter.
[b, a] = butter(6,fc/(F1/2));
% Apply the Butterworth filter.
filteredSignal = filter(b, a, s1);
% Figure 4 Mystere 1 Filtre - Fichier Entier
figure(4),plot(filteredSignal), title('Mystere 1 Filtre - Fichier entier');
% Figure 5 Mystere 1 Filtre - Seconde du Signal
figure(5),plot(filteredSignal), title('Mystere 1 Filtre - Premiere Seconde');
xlim([0 F1]);
% Figure 6 Mystere 1 Filtre - Spectrogramme
figure(6),specgram(filteredSignal, 512, F1), title('Mystere 1 Filtre - Spectrogramme');
% Jouer le signal flitre
sound(filteredSignal*80,F1);
% Ecrire le fichier de sortie (voix claire)
audiowrite('mystere1_voix.wav',filteredSignal*80,F1);

% FICHIER MYSTERE 2
[s2,F2] = audioread('media/mystere2.wav');
% Figure 7 Mystere 2 - Fichier Entier
figure(7),plot(s2), title('Mystere 2 - Fichier entier');
% Figure 8 Mystere 2 - Seconde du Signal
figure(8),plot(s2), title('Mystere 2 - Premiere Seconde');
xlim([0 F2]);
% Figure 9 Mystere 2 - Spectrogramme
figure(9),specgram(s2, 512, F2), title('Mystere 2 - Spectrogramme');

% Mystere 2 - Filtre 
fc = 350;
% Design a Butterworth filter.
[b, a] = butter(6,fc/(F2/2),'high');
% Apply the Butterworth filter.
filteredSignal2 = filter(b, a, s2);
% Figure 4 Mystere 1 Filtre - Fichier Entier
figure(10),plot(filteredSignal2), title('Mystere 2 Filtre - Fichier entier');
% Figure 5 Mystere 1 Filtre - Seconde du Signal
figure(11),plot(filteredSignal2), title('Mystere 2 Filtre - Premiere Seconde');
xlim([0 F1]);
% Figure 6 Mystere 1 Filtre - Spectrogramme
figure(12),specgram(filteredSignal2, 512, F2), title('Mystere 2 Filtre - Spectrogramme');
% Jouer le signal flitre.
sound(filteredSignal2*50,F2);
% Ecrire le fichier de sortie (voix claire)
audiowrite('mystere2_voix.wav',filteredSignal2*50,F1);