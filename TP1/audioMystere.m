%{[s1,F1] = audioread('media/mystere1.wav');
figure(1),plot(s1), title('Mystere 1');
xlim([0 F1]);
duration1 = length(s1)/F1; 
n = length(s1);     % Total number of samples
t = (0:n-1)/F1;      % Time for entire signal
fprintf('Total number of samples = %f \n',n);
fprintf('S1 duration = %f seconds \n',duration1);
fprintf('Frequency = %f \n',F1);

% Filtre pour le premier fichier mystere
% https://www.mathworks.com/matlabcentral/answers/317340-how-to-filtre-an-audio-signal-with-low-pass-filtre
fc = 1300; % Make higher to hear higher frequencies.
% Design a Butterworth filter.
[b, a] = butter(6,fc/(F1/2));
figure(2),freqz(b,a), title('Mystere 1');
% Apply the Butterworth filter.
filteredSignal = filter(b, a, s1);
figure(3),plot(filteredSignal), title('Mystere Filtree 1');
xlim([0 F1]);
% Play the sound.
sound(filteredSignal*80,F1);
