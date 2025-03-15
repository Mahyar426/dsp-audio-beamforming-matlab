clc
clear all
close all
%%
r = audiorecorder(22050, 16, 1);
record(r);     % speak into microphone...
play(r);   % listen
stop(r);
mySpeech = getaudiodata(r, 'double'); % get data as int16 array
n=norm(mySpeech);


