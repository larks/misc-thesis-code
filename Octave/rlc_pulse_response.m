%Example5.m
t = 0:.00001:.005;
%Overdamped - R = 1K, L = 1mh, C = 1uf
vc = 1 - .989898*exp(-1010.2*t) - .010102*exp(-98990*t);
figure(1);clf;
plot(t, vc, 'k'); %plot the overdamped case in black
%Turn on hold so all plots go to figure 1
hold on;
vc = 1 - (1 + 10000*t).*exp(-10000*t);
plot(t, vc, 'r'); %plot the critically damped case in red
%Underdamped - R = 40, L = 1mh, C = 1uf
w = 10000;
vc = 1 - (cos(w*t) + .2*sin(w*t)).*exp(-2000*t);
plot(t, vc, 'blue'); %plot the underdamped case in blue
%Add title and x and y axis labels
title('RLC Step Response');
xlabel('Time in seconds');
ylabel('Voltage in volts');
%Add text to mark the cases and draw a line from the
% text to each graph
text(.001, 1.3, 'Underdamped case');
x = [.001 .00043]; y = [1.3 1.2];
line(x, y);
text(.001, .4, 'Overdamped case');
x = [.001 .0005]; y = [.4 .4];
line(x, y);
text(.0015, .6, 'Critically damped case');
x = [.0015 .00015]; y = [.6 .5];
line(x, y);
