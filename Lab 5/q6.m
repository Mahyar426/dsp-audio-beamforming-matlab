clc
clear
close all
%%
x = audioread('m01iy.wav');
%figure,plot(x);
%%
l = length(x);
N = 512;
n = fix(l/N);
Ft = [];
%%
%w = hann(512);
w = hamming(N);
%w = bartlett(512);
%w = blackman(512);
%w = rectwin(512);
%%
for i = 1 : n
    s = x((i-1)*N + 1:i*N).*w;
    Ft(i,:)= abs((fft(s,N)));
    S = [];
    S_t = [];
    for eta = 1 : N/2
        S=[S,s(eta:N-N/2+eta-1)];
        S_t = [S_t , S];
    end
    amdff(i,:)= sum(abs(s(1:N-N/2) - S));
end
%%
figure,plot(amdff(1,:));
figure,plot(amdff(6,:));
% for autocorrelation we use q5.m