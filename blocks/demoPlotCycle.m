setup
close all;

% set n
n = 10;

[eNet, eNetMCU, eNetTRX, cycle] = operateCycle(config, n);
%rectSum(cycleADC(1,:), cycleADC(2, :), 'm');
% plot(cycleADC(1,:), cycleADC(2,:), 'b');
semilogy(cycle.ADC(1,:), cycle.ADC(2,:), 'b');

hold on;

rectSum(cycle.TRX(1,:), cycle.TRX(2, :), 'm')
disp(eNetTRX);
% plot(cycleTRX(1,:), cycleTRX(2,:), 'r');
semilogy(cycle.TRX(1,:), cycle.TRX(2,:), 'r');

xlabel('Time (seconds)');
ylabel('Power(watts)');
title('Single Cycle Power Usage');

legend('Sample Readings', 'Transmission');