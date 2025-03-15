clc
clear
close all
%%
x = audioread('n13oo.wav');
Cp = 0.1;Cm = -0.1;
x(find(x>Cp)) = x(find(x>Cp))-Cp;
x(find(x<Cm)) = x(find(x<Cm))-Cm;
x(find(x<Cp & x>Cm)) = 0;
stem(x);
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
    for eta = 1 : 256
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