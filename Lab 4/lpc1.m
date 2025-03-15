clc
clear all
close all
x=audioread('y25oo.wav')';
r=4;
for i=1:r
    for j=1:r
        mat_1=cat(2,zeros(1,i),x);
        mat_2=cat(2,zeros(1,j),x);
        if(size(mat_1,2)>=size(mat_2,2))
            mat_1=cat(2,mat_1,zeros(1,1));
            mat_2=cat(2,mat_2,(zeros(1,size(mat_1,2)-size(mat_2,2)+1)));
        end
        if(size(mat_2,2)>=size(mat_1,2))
            mat_1=cat(2,mat_1,(zeros(1,size(mat_2,2)-size(mat_1,2)+1)));
            mat_2=cat(2,mat_2,zeros(1,1));
        end
        coef_1(i,j)=sum(mat_1.*mat_2);
    end
        coef_2(1,i)=sum(([x zeros(1,i)]).*([zeros(1,i) x]));
end
my_lpc=[1 -1*((coef_2*inv(coef_1)))];
matlab_lpc=lpc(x,r);