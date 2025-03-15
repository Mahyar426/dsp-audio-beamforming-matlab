clc
clear all
close all
%%
range=1:100;
for i=1:3
    p=10+5*i;
    for j=1:3
        k=30+5*i;
        for n=1:100
            if(n<p)
               g(n)=(1-cos(pi*n/p))/2;
            end
            if ((n>p)&&(n<k))
               g(n)=(cos((pi*(n-p))/((k-p)*2)))
            end
            if (n>k)
               g(n)=0;
            end
        end
        subplot(3,3,(3*(i-1))+j)
        stem(range,g);
    end
end