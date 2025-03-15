clc
clear
close all
%%
x = audioread('n13oo.wav');
%x = audioread('m01iy.wav'); for q6
plot(x);
%%
leng = length(x);
N = 512;
Ft = [];
n = fix(leng/N);
windoww = hamming(N);
%%
for i = 1 : n
    s = x((i-1)*N + 1:i*N).*windoww;
    Ft(i,:)= abs(fftshift(fft(s,N)));
    S = [];
    for eta = 1 : N/2
        S=[S,s(eta:N-N/2+eta-1)];
    end
    Autocor(i,:) = s(1:N-N/2)' * S;
end
%%
figure;
plot(Autocor(1,:));
figure;
plot(Autocor(6,:));
figure;
plot(Ft(1,:));
figure;
plot(Ft(6,:));