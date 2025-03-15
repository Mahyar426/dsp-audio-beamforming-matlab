%% Mohadeseh Ghafoori 9632133 Mahyar Onsori 9632093
%%
clc
close all
clear all
%% Data Reading
[data,Fs]=audioread('recorded_data1_2K.wav');
%[data,Fs]=audioread('recorded_data2_2K.wav');
%[data,Fs]=audioread('recorded_data3.wav');
%% Parameters
theta=90;
speed=343;
fs=48000;
frame_length=fs/5;
nt=1;
phiii=0:1:359;
sample_num=size(data,1);
window_num=sample_num/frame_length;
das_total=zeros(window_num,360);
mv_total=zeros(window_num,360);
%% Mic
%Microphone position 2:
x1=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042;
y1=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042;
z1=zeros(1,16);
 %% 
[b,a] = butter(5,5000/Fs*2,'low');
[c,d] = butter(5,4000/Fs*2,'high');
filt_data = zeros(size(data));
for j=1:16
    temp1 = filtfilt(b,a,data(:,j));
    filt_data(:,j) = filtfilt(c,d,temp1);
    %temp1 = filter(b,a,data(:,j));
    %filt_data(:,j) = filter(c,d,temp1);
end
figure;
%%
for i=1:window_num
    selected_data=(data((i-1)*frame_length+1:i*frame_length,:));
    das_total(i,:)=DAS(speed,fs,theta,x1,y1,(selected_data)');
    mv_total(i,:)=minvar(speed,fs,theta,x1,y1,(selected_data)');
    disp(['Iteration: ',num2str(i)]);
    plot(phiii,das_total(i,:),'c');
    hold on;
    plot(phiii,mv_total(i,:),'k');
    hold off;
    xlim([0,360]);
    pause(0.01);
end
%% waterfall
X=repmat(phiii,[size(das_total,1),1]);
Y=repmat((1:size(das_total,1))',[1,numel(phiii)]);
figure;
waterfall(X,Y,squeeze(das_total));
colormap('jet');
xlim([min(phiii) max(phiii)]);
ylim([1 size(mv_total,1)]);
xlabel('phi');
ylabel('window number');
az = 0;
e1 = 90;
view(az,e1);
% % %
figure;
waterfall(X,Y,squeeze(mv_total));
colormap('jet');
xlim([min(phiii) max(phiii)]);
ylim([1 size(mv_total,1)]);
xlabel('phi');
ylabel('window number');
az = 0;
e1 = 90;
view(az,e1);