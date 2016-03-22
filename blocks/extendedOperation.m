function [opCycleADC opCycleTRX] = extendedOperation(config, vec)
% vector vec contains available energies
opCycleADC = [];
opCycleTRX = [];
for i = 1:length(vec)
    [eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes, D] = operateWindow(vec(i), config);
    windowADC(1,:) = windowADC(1,:) + (i-1)*config.T_tx*config.k;
    windowTRX(1,:) = windowTRX(1,:) + (i-1)*config.T_tx*config.k;
    opCycleADC = [opCycleADC windowADC];
    opCycleTRX = [opCycleTRX windowTRX];
end
end