%nn = 3
%tt=0:nn/1024:nn;
%balle=511+511*sawtooth(tt,0.5);
%plot(balle);

a=511
T=0.1
t=[0:0.001:1];
y=a*mod(t,T);
plot(t,y);
ylabel ('Amplitude');
xlabel ('Time Index');
title('Triangular waveform');
