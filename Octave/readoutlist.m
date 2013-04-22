%% write activate readout of all channels of FEC 4
% ALTRO 0
FILfour = fopen('readout_FEC4.sh','w');
FILall  = fopen('readout_FEC4_FEC14.sh','w');
fprintf(FILfour,'rcu-sh w 0x1000 2048 0xfff\n');
fprintf(FILall,'rcu-sh w 0x1000 2048 0xfff\n');
reg = 0;
kk = 0;
for ii=0:15
    fprintf(FILfour,'rcu-sh w 0x100%x 0x20%x\n', ii, kk);
	fprintf(FILall,'rcu-sh w 0x100%x 0x20%x\n',  ii, kk);
	kk=kk+1;
end
for ALTRO=2:4
		kk = 0;
	for ii=0:15
		fprintf(FILfour,'rcu-sh w 0x10%x%x 0x2%x%x\n', ALTRO-1, ii, ALTRO, kk);
		fprintf(FILall,'rcu-sh w 0x10%x%x 0x2%x%x\n',  ALTRO-1, ii, ALTRO, kk);
		kk=kk+1;
	end
end
fclose(FILfour); % done with FEC4 only script
%% FEC 14
FILfourteen = fopen('readout_FEC14.sh','w');
% ALTRO0
kk=0;
for ii=0:15
    fprintf(FILfourteen,'rcu-sh w 0x100%x 0x70%x\n', ii, kk);
    fprintf(FILall,'rcu-sh w 0x104%x 0x70%x\n', ii, kk);
    kk=kk+1;
end
for ALTRO=2:4
        kk = 0;
    for ii=0:15
        fprintf(FILfourteen,'rcu-sh w 0x10%x%x 0x7%x%x\n', ALTRO-1, ii, ALTRO, kk);
        fprintf(FILall,'rcu-sh w 0x10%x%x 0x7%x%x\n',      ALTRO+3, ii, ALTRO, kk);
        kk=kk+1;
    end
end

fclose(FILfourteen);
fclose(FILall);
