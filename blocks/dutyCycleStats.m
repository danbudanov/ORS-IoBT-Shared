function [avg] = dutyCycleStats(time, dutyCycle)
T = time(end);
net = rectSum(time, dutyCycle, 'l');
avg = net / T;


end