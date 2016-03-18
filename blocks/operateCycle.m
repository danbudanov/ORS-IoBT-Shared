function [eNet, eNetMCU, eNetTRX, cycleADC, cycleTRX] = operateCycle(config, n)

% TODO: generate plots for TRX and MCU %

[eMCU, tMCU] = mcuBlock(config); % takes care of the number of trials
switch config.txDataParam
    case 0
        [eTRX, tTRX] = trxBlock(config, 8*n*config.numSamp); %transmit averaged data
    case 1
        [eTRX, tTRX] = trxBlock(config, 8*n*config.numSamp*config.trials); %transmit data
end
eSleepTRX = trxSleep(config, config.T_tx - tTRX);
tSleepMCU = config.T_tx - n*tMCU - tTRX;
eSleepMCU = mcuSleep(config, tSleepMCU);

eNet = n*eMCU + eTRX + eSleepTRX + eSleepMCU;
eNetMCU = n*eMCU + eSleepMCU;
eNetTRX = eTRX + eSleepTRX;

%------------------------------------------------------------------
%% ADC sampling Duty Cycle
% generate time domains and sampling points
openToSample = config.T_tx - tTRX;
samplingStarts = linspace(0, openToSample, n+2); % will remove first and last points to make optimally spaced
samplingStarts = samplingStarts(2:end-1);
% expand active points by creating vectors to + tMCU around them
samplingEnds = samplingStarts(1:end)+tMCU;
samplingPoints = [samplingStarts samplingEnds];
% determing average active powers
pSamplings = ones(1, length(samplingPoints));
pSamplings = pSamplings * eMCU / tMCU; % power when in active mode
% add a miniscule amount to active vector bounds and set to sleep power
sleepStarts = samplingStarts(1:end) - 1e-9;
sleepEnds = samplingEnds + 1e-9;
sleepPoints = [sleepStarts sleepEnds openToSample 0 1];
pSleepMCU = ones(1,length(sleepPoints)) * eSleepMCU / tSleepMCU;

% net time points and associated powers
samplingPoints = [samplingPoints sleepPoints];
pSamplings = [pSamplings pSleepMCU];

%sort samplingPoints and pSamplings wrt the former
[samplingPoints, idx] = sort(samplingPoints);
pSamplings = pSamplings(idx);
cycleADC = [samplingPoints; pSamplings];
%potentially interpolate other points within sleep or active range
%------------------------------------------------------------------
%samplingCycle = repmat(generateSampling(),1,5);

%% TRX Duty Cycling

pTRX = eTRX / tTRX;
pTRX_Sleep = eSleepTRX / openToSample;

trxBefore = openToSample - 2e-9;
trxStarts = openToSample - 1e-9;
trxEnds = trxStarts + tTRX;
trxStop = trxEnds + 1e-9;

cycleTRX = [0 trxBefore trxStarts trxEnds trxStop config.T_tx; pTRX_Sleep pTRX_Sleep pTRX pTRX pTRX_Sleep pTRX_Sleep];

end