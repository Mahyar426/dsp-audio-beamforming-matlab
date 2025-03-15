clc
clear all
close all
%%
p=5;
k=9;
range=1:100;
        for n=1:100
            if(n<p)
               g(n)=(1-cos(pi*n/p))/2;
            end
            if ((n>p)&&(n<k))
               g(n)=(cos((pi*(n-p))/((k-p)*2)));
            end
            if (n>k)
               g(n)=0;
            end
        end
GF=fft(g,128);
GF1=fftshift(GF);
ly = length(GF);
f = (-ly/2:ly/2-1)/ly;
mag=abs(GF1);
phas=angle(GF1);
subplot(1,2,1);
stem(f,mag);
subplot(1,2,2);
plot(f,phas); 