%Run Scirpt for  Simulation

file_name = input('What is the file name? ','s');
lineskp = 1;
[time,irrandance,win] = ReadData(file_name,lineskp);
irrandance = NaNDetect(irrandance);
loop = true;
% [time,irrandance] = future(time,irrandance,1000);
% plot(time,irrandance,'r')
while(loop)
    loop = input('Continue or stop? ','s');
    if isempty(loop)
        loop = true;
    elseif strcmpi(loop,'stop')
        loop = false;
        continue
    end
[time,irrandance] = future(time,irrandance,win);
% av_irrandance = MovingAverage(irrandance);
% plot(time,irrandance,'r')
% hold on
% plot(time,av_irrandance,'k')
% plot(time(win),irrandance(win),'xb')
% hold off
[harvestedEnergy,harvestedVoltage,E_av] = harvested(irrandance,win);
% figure
% plot(time, harvestedEnergy,'b')
disp('Energy Available in the Next Window (J):')
disp(E_av)
[storedEnergy, E_sc] = storage(harvestedVoltage, win);
figure
plot(time,storedEnergy,'k')
disp('Energy Available in SuperCap in the Next Window (J):')
disp(E_sc)
disp((E_sc*30)/2)
end