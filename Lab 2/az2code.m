%% Mohadeseh Ghafoori 9632133 Mahyar Onsori 9632093
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
POWER=zeros(1,360);
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
%% Produce data_Decreasing and increasing the number of arrays
  phii=[51,71];
  siig=randn(9600,numel(phii));
  
  x1d_1=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042;
  pos1=[x1d_1;y1d;z1d];
  data1d1= produce_data(siig,pos1,Fs,phii,c);
  
  x1d_2=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042*2;
  pos2=[x1d_2;y1d;z1d];
  data1d2= produce_data(siig,pos2,Fs,phii,c);
  
  x1d_3=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042*3;
  pos3=[x1d_3;y1d;z1d];
  data1d3= produce_data(siig,pos3,Fs,phii,c);
  
  x1d_4=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]*0.042*4;
  pos4=[x1d_4;y1d;z1d];
  data1d4= produce_data(siig,pos4,Fs,phii,c);
  
  
  x2d_1=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042;
  y2d_1=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042;
  pos5=[x2d_1;y2d_1;z2d];
  data2d1=produce_data(siig,pos5,Fs,phii,c);

  x2d_2=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042*2;
  y2d_2=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042*2;
  pos6=[x2d_2;y2d_2;z2d];
  data2d2=produce_data(siig,pos6,Fs,phii,c);
  
  x2d_3=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042*3;
  y2d_3=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042*3;
  pos7=[x2d_3;y2d_3;z2d];
  data2d3=produce_data(siig,pos7,Fs,phii,c);
  
  x2d_4=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042*4;
  y2d_4=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042*4;
  pos8=[x2d_4;y2d_4;z2d];
  data2d4=produce_data(siig,pos8,Fs,phii,c);
  %% Decreasing and increasing the number of microphones
for g4=1:2
    data_nummic_2(g4,:)=data2_linear(g4,:);
    x1dd1(1,g4)=x1d(1,g4);
end
for g1=1:4
    data_nummic_4(g1,:)=data2_linear(g1,:); 
        x1dd2(1,g1)=x1d(1,g1);
end
for g2=1:6
    data_nummic_6(g2,:)=data2_linear(g2,:);
        x1dd3(1,g2)=x1d(1,g2);
end
for g3=1:8
    data_nummic_8(g3,:)=data2_linear(g3,:); 
        x1dd4(1,g3)=x1d(1,g3);
end
w=size(x1dd1,2);
%a=ones(w,1);
a=ones(16,1);
%% Compensating Delay and Calculating SNR
%out=awgn(data_nummic_6,100,'measured'); %SNR PRE
for phi=0:1:359
    for mic=1:16
        delays(mic,(phi+1))=takhir((x1d(1,mic)),(y1d(1,mic)),(z2d(1,mic)),c,phi,theta); %Calculating the delay needed for compensation
        sample_delays(mic,(phi+1))=round(delays(mic,(phi+1))*Fs); % Applying to number of samples
        final_delay(mic,:)=circshift(data2_linear(mic,:),((-1)*sample_delays(mic,(phi+1)))); %Compensating the delay caused by distance between first microphone and desired microphone
    end
    R=final_delay*transpose(final_delay);
    POWER(phi+1)=1/(transpose(a)*inv(R)*a);
end
POWER_rescale=rescale(POWER);
%% Plotting
figure;
title('Original Signal')
plot(POWER_rescale);
grid on