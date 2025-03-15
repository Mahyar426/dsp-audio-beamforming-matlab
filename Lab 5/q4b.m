clc
clear all
close all
range=1:64;
alpha=0.85;
beta=0.75;
for n=1:64
    g(n)=alpha^n-beta^n;
end
GF=fft(g,128);
GF1=fftshift(GF);
ly = length(GF);
f = (-ly/2:ly/2-1)/ly;
mag=abs(GF1);
phas=angle(GF1);
subplot(1,2,1)
stem(f,mag);
subplot(1,2,2)
plot(f,phas);