function [avg, varr] = extOpStats(eAvVec, config)
setup;

[opADC, opTRX ,D_MCU, D_TRX, bytesVec] = extendedOperation(config, eAvVec);

avg.TRX = mean(D_TRX);
avg.MCU = mean(D_MCU);
varr.TRX = var(D_TRX);
varr.MCU = var(D_MCU);
end