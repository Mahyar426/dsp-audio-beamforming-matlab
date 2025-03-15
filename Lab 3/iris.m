clc
clear all
close all
load fisheriris
X = meas;
Y = species;
Md1 = fitcknn(X,Y,'NumNeighbors',5,'distance','chebychev');
Md2 = fitcknn(X,Y,'NumNeighbors',5,'distance','hamming');
Md3 = fitcknn(X,Y,'NumNeighbors',5,'distance','minkowski');
Md4 = fitcknn(X,Y,'NumNeighbors',5,'distance','cityblock');
Md5 = fitcknn(X,Y,'NumNeighbors',5,'distance','euclidean');
P1=predict(Md1,[5.7,2.8,4.5,1.3])
P2=predict(Md2,[5.7,2.8,4.5,1.3])
P3=predict(Md3,[5.7,2.8,4.5,1.3])
P4=predict(Md4,[5.7,2.8,4.5,1.3])
P5=predict(Md5,[5.7,2.8,4.5,1.3])
cvmd1=crossval(Md1);
cvmd2=crossval(Md2);
cvmd3=crossval(Md3);
cvmd4=crossval(Md4);
cvmd5=crossval(Md5);
loss1=kfoldLoss(cvmd1)
loss2=kfoldLoss(cvmd2)
loss3=kfoldLoss(cvmd3)
loss4=kfoldLoss(cvmd4)
loss5=kfoldLoss(cvmd5)



