%% Mahyar Onsori 9632093
%%
clc
clear all
close all
%% Defining Parameters
c=330;  			%sound speed propagation (m/s)
Fs = 48000;   		%samppling frequency (Hz)
theta=90;
delays=zeros(16,360);
sample_delays=zeros(16,360);
norm_allsum=[];
y_total=[];
%% Loading datas
load('data1_2D.mat');
load('data2_2D.mat');
load('data3_2D.mat');
load('data1_linear.mat');
load('data2_linear.mat');
load('test_data_50_degree.mat');
[m,n]=size(data1_2D); %we can alter data1_2D with other matrices
%% Mic 1D
% Microphone position 1:
 x1d=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042;
 y1d=zeros(1,16);
 z1d=zeros(1,16);
%% Mic 2D
%Microphone position 2:
x2d=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042;
y2d=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042;
z2d=zeros(1,16);
%% Decreasing and increasing the number of arrays
data_staticmic_1=zeros(m,n);
data_staticmic_2=zeros(m,n);
data_staticmic_3=zeros(m,n);
% we define these matrices parametrically to have a compatible code! :)
for r=3:4:15
    data_staticmic_1(r,:)=data2_linear(r,:);
end
for s=1:2:7
    data_staticmic_2(s,:)=data2_linear(s,:);
end
for w=1:1:4
    data_staticmic_3(w,:)=data2_linear(w,:);
end
%% Decreasing and increasing the number of microphones
data_nummic_2=zeros(m,n);
data_nummic_4=zeros(m,n);
data_nummic_6=zeros(m,n);
data_nummic_8=zeros(m,n);
% we define these matrices parametrically to have a compatible code! :)
for g4=1:2
    data_nummic_2(g4,:)=data2_linear(g4,:); 
end
for g1=1:4
    data_nummic_4(g1,:)=data2_linear(g1,:); 
end
for g2=1:6
    data_nummic_6(g2,:)=data2_linear(g2,:); 
end
for g3=1:8
    data_nummic_8(g3,:)=data2_linear(g3,:); 
end

%% Compensating Delay and Calculating SNR
%out=awgn(data_nummic_6,100,'measured'); %SNR PRE
for phi=0:1:359
    for mic=1:16
        delays(mic,(phi+1))=takhir((x1d(1,mic)),(y1d(1,mic)),(z2d(1,mic)),c,phi,theta); %Calculating the delay needed for compensation
        sample_delays(mic,(phi+1))=round(delays(mic,(phi+1))*Fs); % Applying to number of samples
        final_delay(mic,:)=circshift(data1_linear(mic,:),((-1)*sample_delays(mic,(phi+1)))); %Compensating the delay caused by distance between first microphone and desired microphone
        allsum=sum(final_delay);
    end
    norm_allsum=[norm_allsum norm(allsum)]; %Calculating the norm of the final signal 
end
y_total=rescale(norm_allsum); %Scaling the norm to the span [0-1]
%out=awgn(y_total,6,'measured'); %SNR POST
%% Plotting
figure;
title('Original Signal')
plot(y_total);
grid on

        
