[signal, f1] = audioread('numeros_mysteres/numero_mystere2.wav');

Y = abs(fft(signal(1:512)));

[pks, pksLoc] = findpeaks(Y);

fprintf('%f', pksLoc(1:2)*15.625);
