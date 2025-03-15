clc
close all
clear all
%% Reading Signal and Cutting It
[input_signal,fs]=audioread('Y25oo.wav');
input_signal_copy=input_signal;
max_input=max(input_signal);
for i=1:size(input_signal_copy,1)
    if(input_signal_copy(i,1)<0.125*max_input)
        input_signal_copy(i,1)=0;
    end
end
for i=1:size(input_signal_copy,1)
    if (input_signal_copy(i,1)~=0)
        start_point=i;
        break;
    end
end
%% Parameters
downsample_rate=5;
sum_of_pitches=0;
counter=0;
fh=800;
w2=fh/(fs/2); % normalize
%% Filtering and Showing the Results
b0=fir1(155,w2,'low');%[w1,w2]); 150 mohem nist
low_pass_signal=filter(b0,1,input_signal);
figure,plot(input_signal,'r')
hold on,plot(low_pass_signal,'b');
%% Pre-emphasis filter
pre_emphasis_signal=filter([1-0.95],1,low_pass_signal); 
%% Calculating Increment and Frame with the Guide of User
prompt='Please Enter Your "Accurate" Estimate of The Pitch : ';
user_estimated_pitch=input(prompt);
num_of_pitches=fs/user_estimated_pitch;
time_of_pitch=1/num_of_pitches;
frequency_after_downsample=fs/downsample_rate;
increment=round(2*frequency_after_downsample*time_of_pitch);
frame=increment;
% inc=64;
% frm=64;
%%
downsampled_signal=pre_emphasis_signal(start_point:downsample_rate:end); %downsampling
w=floor((length(downsampled_signal)-frame)/increment);
for i=1:w
    signal_frame=downsampled_signal((1+(i-1)*increment):(frame+(i-1)*increment));
    meanframe=1/frame*sum(signal_frame);
    signal_frame=signal_frame-meanframe;
    a=lpc(signal_frame,4);
    y=filter(a,1,signal_frame);% Estimated Signal
    figure,plot(20*log10(abs(fft(signal_frame))))
    hold on,plot(20*log10(abs(fft(y))))
    figure,plot(xcorr(y))
    corr_y=xcorr(y);
    [af,bf]=max(corr_y(length(y)+1:end));
    ds_pitch(i)=bf(1);
    pause
    close all
end
%% Estimating Pitch
pitch_mat=downsample_rate*ds_pitch;
for jj=1:size(pitch_mat,2)
    if ( pitch_mat(1,jj) > 0.75 * max(pitch_mat) )
        sum_of_pitches=sum_of_pitches+pitch_mat(1,jj);
        counter=counter+1;
    end
end
est_pitch=fs/(sum_of_pitches/counter);
