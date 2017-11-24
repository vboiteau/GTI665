function Fz = highPassFilter(chunk)
    a = 0.9375;
    Fz = 1 - a*chunk.^-1;
end