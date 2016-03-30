function displayFull(eAvVec)
close all;
setup;

[opADC, opTRX ,D_MCU, D_TRX, bytesVec] = extendedOperation(config, eAvVec);

avgTRX = mean(D_TRX);
avgMCU = mean(D_MCU);
varTRX = var(D_TRX);
varMCU = var(D_MCU);

% Available Energy Plot
subplot(4,1,1)
numWin = 0:length(eAvVec)-1;
times = config.k*config.T_tx * numWin;
times = [times; times + config.k*config.T_tx-1e-9];
times = times(:)';
enVec = [eAvVec; eAvVec];
enVec = enVec(:)';
plot(times, enVec);
xlabel('Time (seconds)');
ylabel('Energy (J)');
title('Energy Available');

% Power used during operation plot
subplot(4,1,2)
% plot(opADC(1,:), opADC(2, :), 'b');
semilogy(opADC(1,:), opADC(2, :), 'b');
hold on;
semilogy(opTRX(1,:), opTRX(2,:), 'r');
% plot(opTRsX(1,:), opTRX(2,:), 'r');
xlabel('Time (seconds)');
ylabel('Power (watts)');
titleText = sprintf('Power usage for %d windows', length(eAvVec));
title(titleText);
legend('Sample Readings', 'Transmission');

% Net Duty Cycle Plot
subplot(4,1,3)
D_MCU = [D_MCU; D_MCU];
D_MCU = D_MCU(:)';
D_TRX = [D_TRX; D_TRX];
D_TRX = D_TRX(:)';
plot(times, D_MCU*100, 'b');
hold on;
plot(times, D_TRX*100, 'r');

% plot averages
plot([times(1), times(end)],[avgTRX, avgTRX] * 100, 'r--');
plot([times(1), times(end)],[avgMCU, avgMCU] * 100, 'b--');

xlabel('Time (seconds)');
ylabel('D (%)');
title('Duty Cycle');


% Plot bytes transmitted
subplot(4,1,4);
bytesVec = [bytesVec; bytesVec];
bytesVec = bytesVec(:)';
plot(times, bytesVec);
xlabel('Time (seconds)');
ylabel('Bytes');
title('Bytes Transmitted');

end % displayFull