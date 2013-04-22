nsamp = 4; % Number of samples per symbol
nsymb = 3; % Number of symbols
s = rand('mt19937ar', 0);
ch1 = randi(s, [0 1], nsymb, 1); % Random binary channel
ch2 = [1:nsymb]';
x = [ch1 ch2] % Two-channel signal
y = rectpulse(x,nsamp)
