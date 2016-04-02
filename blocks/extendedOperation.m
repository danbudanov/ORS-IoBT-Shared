function [opCycleADC, opCycleTRX, D_MCU, D_TRX, bytesVec] = extendedOperation(config, vec)
% vector vec contains available energies
opCycleADC = [];
opCycleTRX = [];
D_MCU = [];
D_TRX = [];
bytesVec = [];
for i = 1:length(vec)
    [eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes, D] = operateWindow(vec(i), config);
    windowADC(1,:) = windowADC(1,:) + (i-1)*config.T_tx*config.k;
    windowTRX(1,:) = windowTRX(1,:) + (i-1)*config.T_tx*config.k;
    opCycleADC = [opCycleADC windowADC];
    opCycleTRX = [opCycleTRX windowTRX];
    
    D_MCU = [D_MCU D.MCU];
    D_TRX = [D_TRX D.TRX];
    bytesVec = [bytesVec bytes];
end
end