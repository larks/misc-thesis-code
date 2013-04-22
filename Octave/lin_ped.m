%% ------------------------------------------------- %%
% Script for creating some pedestal memory patterns
%  Tested using Octave on Ubuntu 11.04 32-bit
%% ------------------------------------------------- %%

clear all; close all;
nn=1024; % number of samples
xx=[0:1023];
yy=xx;

% for good measure
sinFile = fopen('csvlin.csv','w');
for i=1:1007
	fprintf(sinFile,'%d,',yy(i));
end
	fprintf(sinFile,'%d\n\n',yy(i+1));
fclose(sinFile);

% Generate file for using with rcu-sh in batch mode
% It will broadcast to all FECs
sinFile = fopen('lin.script','w');
i=1;
for j=1:4:4*(length(yy)-1)
	fprintf(sinFile,'w 0x%X 0x24000D\n', j);
	fprintf(sinFile,'w 0x%X 0x%03X # ADDR\n', j+1, i-1);
	fprintf(sinFile,'w 0x%X 0x240007\n', j+2);
	fprintf(sinFile,'w 0x%X 0x%03X # DATA\n', j+3, yy(i) );
	i=i+1;	
end
	fprintf(sinFile, 'w 0x%X 0x380000 # End of set of instructions\n',j+4);
	fprintf(sinFile, 'w 0x5304 0xF # Execute\n');
	fprintf(sinFile, 'r 0x2000 1024 -a resmem_pedestal_fill.txt');
fclose(sinFile);

