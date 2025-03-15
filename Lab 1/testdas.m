clc
clear all
close all
c=330;  			%sound speed propagation (m/s)
Fs = 48000;   		%samppling frequency (Hz)
theta=90;
x1d=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042;
y1d=zeros(1,16);
z1d=zeros(1,16);
microphone=[x1d,y1d,z1d];
load('data1_linear.mat');
P1=DAS(c,Fs,theta,x1d,y1d,data1_linear);
plot(P1)
grid on
