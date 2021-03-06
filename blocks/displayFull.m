function [avg, varr] = displayFull(eAvVec, eSc)
close all;
setup;

[opADC, opTRX ,D_MCU, D_TRX, bytesVec] = extendedOperation(config, eAvVec);

avg.TRX = mean(D_TRX);
avg.MCU = mean(D_MCU);
varr.TRX = var(D_TRX);
varr.MCU = var(D_MCU);

numWin = 0:length(eAvVec)-1;
times = config.k*config.T_tx * numWin;
times = [times; times + config.k*config.T_tx-1e-9];
times = times(:)';
% Supercapacitor Energy Plot
eSc = [eSc; eSc];
eSc = eSc(:)';
% tSpaced = linspace(times(1), times(end), length(eSc)*100);
% eScInterp = interp1(times, eSc, tSpaced, 'pchip');
subplot(5,1,1)
plot(times, eSc);
title('Supercapacitor Energy Plot');
ylabel('Energy (J)');
xlabel('Time (s)');
% Available Energy Plot
subplot(5,1,2)
% numWin = 0:length(eAvVec)-1;
% times = config.k*config.T_tx * numWin;
% times = [times; times + config.k*config.T_tx-1e-9];
% times = times(:)';
enVec = [eAvVec; eAvVec];
enVec = enVec(:)';
plot(times, enVec);
xlabel('Time (seconds)');
ylabel('Energy (J)');
title('Energy Available');

% Power used during operation plot
subplot(5,1,3)
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
subplot(5,1,4)
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
subplot(5,1,5);
bytesVec = [bytesVec; bytesVec];
bytesVec = bytesVec(:)';
plot(times, bytesVec);
xlabel('Time (seconds)');
ylabel('Bytes');
title('Bytes Transmitted');


end % displayFull