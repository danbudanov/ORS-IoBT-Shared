% demoExtOp
close all;
eAvVec = [0 .5 .33]
[opADC, opTRX] = extendedOperation(config, eAvVec)
plot(opADC(1,:), opADC(2, :), 'b');
hold on;
plot(opTRX(1,:), opTRX(2,:), 'r');
