[eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes] = operateWindow(eAvailable, config)
[eRx, tRx] = rx(vIn, numBytes, dataRate, mode)
[energy, time] = wakeup(config)
[eTot, tADC, bytes] = operateADC(config)
adcProfile = loadADCProfile(fname)
[eSleep] = sleepStates(vIn, LPM, time)
[energy, time, bytes]= operateMCU(config, time);
[eTx, tTx] = tx(vIn, numBytes, pwr, dataRate)
[eMCU, tMCU] = mcuBlock(config)
[eTRX, eMCU] = trxBlock(config, numBit)
n = findN( eAv, config)
rsum = rectSum(x,y, mode)
contTimes = makeContTimes(vec, k, T)
[eNet, eNetMCU, eNetTRX, cycleADC, cycleTRX] = operateCycle(config, n)