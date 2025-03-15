%%
clc
close all
clear all
%% 
range=1:100;
for i=1:3
    alpha=(805+45*i)/1000;
    for j=1:3
        beta=(205+45*j)/1000;
        for n=1:1:100
               g(n)=alpha^n-beta^n;
        end
        subplot(3,3,(3*(i-1))+j)
        stem(range,g);
    end
end

