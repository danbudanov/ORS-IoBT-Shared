% Generate window energies and duty cycles
[eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes, D] = operateWindow(eAvailable, config)

% Energy it takes to wake mote up
[energy, time] = wakeup(config)

% Information about taking sensor reading
[eTot, tADC, bytes] = operateADC(config)

% Load in the sensor profile
adcProfile = loadADCProfile(fname)

% Energy expended as TRX is sleeping
[eTRX] = trxSleep(config, time)

% Energy exp. as TRX is sleeping
[eMCU] = mcuSleep(config, time)

% Information on operating the MCU in general
[energy, time, bytes]= operateMCU(config, time);

% Information on transmittinng data
[eTx, tTx] = tx(vIn, numBytes, pwr, dataRate)

% General MCU operation block
[eMCU, tMCU] = mcuBlock(config)

% General TRX operation block
[eTRX, eMCU] = trxBlock(config, numBit)

% Find the number of samplings per cycle allowed
n = findN( eAv, config)

% Diagnostic tool for finding [rectangular] Riemann sum
rsum = rectSum(x,y, mode)

% Make cycle times into window times
contTimes = makeContTimes(vec, k, T)

% Operation of a single cycle; multiple identical cycles make a window
[eNet, eNetMCU, eNetTRX, cycle, D] = operateCycle(config, n)

% Operate for multiple windows
[opCycleADC opCycleTRX] = extendedOperation(config, vec)

% Display extended (multi-window) operation
displayExtOp(eAvVec)

