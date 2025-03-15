clc
clear
close all
%% parameters
Fs = 48000;
phi = 0:1:359;
speed = 343;
% theta = [1:180];
theta = 90;
NT = 1;
audioFrameLength = Fs/5 ;
%%
sen_num = 16;
selected_sensors = [1:16]; 
% Microphone position 1:
x1=[1 0 1 0 1 0 1 0 3 2 3 2 3 2 3 2]*0.042;
y1=[0 0 1 1 2 2 3 3 3 3 2 2 1 1 0 0]*0.042;
z1=zeros(1,sen_num);

x1 = x1(selected_sensors);
y1 = y1(selected_sensors);
z1 = z1(selected_sensors);
pos = [x1;y1;z1];

[b,a] = butter(5,2500/Fs*2,'low');
[c,d] = butter(5,1500/Fs*2,'high');
%freqz(b,a);
%%
[data,Fs] = audioread('recorded_data3.wav');
filt_data = zeros(size(data));
for i=1:16
    temp1 = filtfilt(b,a,data(:,i));
    filt_data(:,i) = filtfilt(c,d,temp1);
    %temp1 = filter(b,a,data(:,i));
    %filt_data(:,i) = filter(c,d,temp1);
end
N_sample = size(data,1);
N_window = N_sample/audioFrameLength;
tot_P_BART = zeros(N_window,360);
tot_P_MVDR = zeros(N_window,360);
figure;
for i=1:N_window
    temp_data = filt_data((i-1)*audioFrameLength+1:i*audioFrameLength,:);
    %temp_data = data((i-1)*audioFrameLength+1:i*audioFrameLength,:);
%     [P_BART,P_MVDR] = time_domain_DOA(temp_data,speed,phi,theta,selected_sensors,x1,y1,z1,Fs);
    P_BART=DAS(speed,Fs,theta,x1,y1,(temp_data));
    P_MVDR=minvar(speed,Fs,theta,x1,y1,(temp_data));
    tot_P_BART(i,:) = P_BART;
    tot_P_MVDR(i,:) = P_MVDR;
    disp(['Iteration: ',num2str(i)]);
    plot(phi,P_BART,'r');
    hold on;
    plot(phi,P_MVDR,'b');
    hold off;
    xlim([0,360]);
    pause(0.01);
end
%% waterfall
X=repmat(phi,[size(tot_P_BART,1),1]);
Y=repmat((1:size(tot_P_BART,1))',[1,numel(phi)]);
figure;
waterfall(X,Y,squeeze(tot_P_BART));
colormap('jet');
xlim([min(phi) max(phi)]);
ylim([1 size(tot_P_MVDR,1)]);
xlabel('phi');
ylabel('window number');
az = 0;
e1 = 90;
view(az,e1);
% % %
figure;
waterfall(X,Y,squeeze(tot_P_MVDR));
colormap('jet');
xlim([min(phi) max(phi)]);
ylim([1 size(tot_P_MVDR,1)]);
xlabel('phi');
ylabel('window number');
az = 0;
e1 = 90;
view(az,e1);