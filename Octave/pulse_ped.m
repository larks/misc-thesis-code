%% ------------------------------------------------- %%
% Script for creating some pedestal memory patterns
%  Tested using Octave on Ubuntu 11.04 32-bit
%% ------------------------------------------------- %%

clear all; close all;
%nn=1024;
%xx=[0:2*pi/nn:2*pi];
%tt=[0:1/1000:nn];

%% Sine wave
%yy=511 + floor( 511*cosint(xx) );

%filt=filter(yy,1)

%figure
%plot(filt);
fs = 11025;  # arbitrary sample rate
f0 = 100;    # pulse train sample rate
w = 0.001;   # pulse width of 1 millisecond
auplot(pulstran(0:1/fs:0.1, 0:1/f0:0.1, 'rectpuls', w), fs);


% Generate file for using with feeGui
%%sinFile = fopen('sine.pat','w');
%%for i=1:(length(yy)-1)
%%	fprintf(sinFile,'0x%x\n',yy(i));
%%end
%%fclose(sinFile);
%figure
%plot(yy);
% Generate file for using with rcu-sh
% It will broadcast to all FECs
%%sinFile = fopen('sine.script','w');
%%i=1;
%%for j=1:4:4*(length(yy)-1)
%	for i=1:(length(yy)-1)
%%	fprintf(sinFile,'w 0x%X 0x24000D\n', j);
%%	fprintf(sinFile,'w 0x%X 0x%03X # ADDR\n', j+1, i-1);
%%	fprintf(sinFile,'w 0x%X 0x240007\n', j+2);
%%	fprintf(sinFile,'w 0x%X 0x%03X # DATA\n', j+3, yy(i) );
%%	i=i+1;	
%	end
%%end
%%	fprintf(sinFile, 'w 0x%X 0x380000 # End of set of instructions\n',j+4);
%%	fprintf(sinFile, 'w 0x5304 0xF # Execute\n');
%%	fprintf(sinFile, 'r 0x2000 1024 -a resmem_pedestal_fill.txt');
%%fclose(sinFile);
%clear yy;

%% Triangle wave - fuck it

%yy=sawtooth(tt,.5); % sawtooth 50% duty cycle
%hh=diff(yy)./diff(xx);
%plot(xx,hh);

% Generate file for using with feeGui
%sawFile = fopen('saw.pat','w');
%for i=1:(length(yy)-1)
%    fprintf(sawFile,'0x%x\n',yy(i));
%end
%fclose(sawFile);
%plot(yy);


%%fid = fopen('sine.pat','r');
%%bakk = fscanf(fid,'%x');
%%figure
%%plot(bakk);

% plot
%figure
%plot(yy)
