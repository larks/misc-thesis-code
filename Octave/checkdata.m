%% This is just plotting one channel from the text-file created by root macro

close all; clear all;
%%xx=[1:1:1008];
data=csvread('run311.txt');
%data=csvread('csvsine.csv');
yy1=data(1,:);
yy1=rot90(rot90(yy1));
figure
plot(yy1,'LineWidth',2);
title('ADC count vs. time -- Output','FontSize',40);
xlabel('Time bins','FontSize',20); ylabel('ADC count','FontSize',20);
grid on;
print -deps yy1.eps
%print -dpng inn.png
print -dpng ut.png

%yy2=data(2,:);
%figure
%plot(yy2,'r');
%yy3=data(3,:);
%figure
%plot(yy3,'g');




%%fid = fopen('filename.txt','r');
%%yy = fscanf(fid,'%x');
%figure
%plot(yy);
