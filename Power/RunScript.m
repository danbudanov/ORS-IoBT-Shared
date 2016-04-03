%Run Scirpt for  Simulation
parpath = cd(cd('..'));
addpath([parpath '\Power']);
addpath([parpath '\blocks']);

v = UserInput();
win = v.data.window;
lineskp = 1;
[time,irrandance] = ReadData(v.file_name,lineskp);
len = length(time);
irrandance = NaNDetect(irrandance);
irrandance = MovingAverage(irrandance,win);
[harvestedEnergy,Eav] = harvested(irrandance,win,v.HT,v.data);
disp('Energy Available in the Last Window (J):')
disp(Eav(end))

disp('Start Operation')
setup;

[~, ~, ~, ~, ~, eNetExp] = extendedOperation(config, Eav);
disp('Finish Operation')

[eSC] = storage(Eav,eNetExp,v.SC);

disp('Energy Available in SuperCap in the Last Window (J):')
disp(eSC(end))

%Add FeedBack

displayFull(Eav, eSC);
% PlotVal

%% Predictive Loop
% loop = true;
disp(['Predictive Method Used : ' v.PM.op])
% while(loop)
%     loop = input('Stop? (y/n) ','s');
%     if isempty(loop)
%         loop = true;
%     elseif strcmpi(loop,'y')
%         loop = false;
%         continue
%     end
    
v.limit = input('How many windows? '); 
disp('Prediticing Now...')

if(isempty(v.limit))
    disp('Exiting...')
    return
end

    for x = 1:v.limit
[time,irrandance] = future(time,irrandance,win,v.PM);

disp('Energy Available in the Next Window (J):')
disp(Eav(end))

[harvestedEnergy,Eav] = harvested(irrandance,win,v.HT,v.data);

disp('Start Operation')
[opADC, opTRX ,D_MCU, D_TRX, eNetExp] = extendedOperation(config, Eav);
disp('Finish Operation')

[eSC] = storage(Eav,eNetExp,v.SC);

disp('Energy Available in SuperCap in the Next Window (J):')
disp(eSC(end))
    end
%Add FeedBack
disp('Done Predicting')

displayFull(Eav,eSC)

%{
% Old
% % [time,irrandance] = future(time,irrandance,win,v.PM);
% % plot(time,irrandance,'r')
% % hold on
% % plot(time,av_irrandance,'k')
% % plot(time(win),irrandance(win),'xb')
% % hold off
% % [harvestedEnergy,harvestedVoltage,E_av] = harvested(irrandance,win,v.HT);
% % figure
% % plot(time, harvestedEnergy,'b')
% % disp('Energy Available in the Next Window (J):')
% % disp(E_av(end))
% % [storedEnergy, E_sc] = storage(harvestedVoltage,win,v.SC);
% % figure
% % plot(time,storedEnergy,'k')
% % disp('Energy Available in SuperCap in the Next Window (J):')
% % disp(E_sc)
% % disp((E_sc*30)/2)
%}
% end
