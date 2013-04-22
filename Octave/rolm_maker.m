%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%  Script for generating ROLM of Bergen PHOS test setup  %
%  with two FECs: #4 and #14.                            %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% write activate readout of all channels of FEC 4
FILfour = fopen('rolm_fec4.txt','w');
FILall  = fopen('rolm_all_fecs.txt','w');
fprintf(FILfour,'');
fprintf(FILall,'');

% ALTRO 0
reg = 0;
kk = 0;
for ii=0:15
    fprintf(FILfour,'0x20%x\n', kk);
	fprintf(FILall, '0x20%x\n', kk);
	kk=kk+1;
end
% ALTRO 2, 3, 4
for ALTRO=2:4
		kk = 0;
	for ii=0:15
		fprintf(FILfour,'0x2%x%x\n', ALTRO, kk);
		fprintf(FILall, '0x2%x%x\n', ALTRO, kk);
		kk=kk+1;
	end
end
fclose(FILfour); % done with FEC4 list
%% FEC 14
FILfourteen = fopen('rolm_fec14.txt','w'); 
% ALTRO0
kk=0;
for ii=0:15
    fprintf(FILfourteen,'0x70%x\n', kk);
    fprintf(FILall,     '0x70%x\n', kk);
    kk=kk+1;
end
% ALTRO 2, 3, 4
for ALTRO=2:4
        kk = 0;
    for ii=0:15
        fprintf(FILfourteen,'0x7%x%x\n', ALTRO, kk);
        fprintf(FILall,'0x7%x%x\n',      ALTRO, kk);
        kk=kk+1;
    end
end
% close all files
fclose(FILfourteen);
fclose(FILall);
