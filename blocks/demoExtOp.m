% demoExtOp
close all;
%eAvVec = [0 .5 .32 0 .4 .5 .2 .6]
eAvVec = rand(1, 10);
[opADC, opTRX] = extendedOperation(config, eAvVec)
subplot(3,1,1)
numWin = 0:length(eAvVec)-1;
times = config.T_tx * numWin;
times = [times; times + config.T_tx-1e-9];
times = times(:)';
enVec = [eAvVec; eAvVec];
enVec = enVec(:)';
plot(times, enVec);

subplot(3,1,2)
% plot(opADC(1,:), opADC(2, :), 'b');
semilogy(opADC(1,:), opADC(2, :), 'b');
hold on;
semilogy(opTRX(1,:), opTRX(2,:), 'r');
% plot(opTRsX(1,:), opTRX(2,:), 'r');
