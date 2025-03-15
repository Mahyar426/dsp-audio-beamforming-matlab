function Das_out=DAS(C,Fs,Theta,x1,y1,data)
%% Defining Parameters
delays=zeros(16,360);
sample_delays=zeros(16,360);
norm_allsum=[];
y_total=[];
%% Loading datas
[m,n]=size(data); %we can alter data1_2D with other matrices
z1=zeros(1,16);
%% Compensating Delay and Calculating SNR
for phi=0:1:359
    for mic=1:16
        delays(mic,(phi+1))=takhir((x1(1,mic)),(y1(1,mic)),(z1(1,mic)),C,phi,Theta); %Calculating the delay needed for compensation
        sample_delays(mic,(phi+1))=round(delays(mic,(phi+1))*Fs); % Applying to number of samples
        final_delay(mic,:)=circshift(data(mic,:),((-1)*sample_delays(mic,(phi+1)))); %Compensating the delay caused by distance between first microphone and desired microphone
        allsum=sum(final_delay);
    end
    norm_allsum=[norm_allsum norm(allsum)]; %Calculating the norm of the final signal 
end
Das_out=rescale(norm_allsum); %Scaling the norm to the span [0-1]
end