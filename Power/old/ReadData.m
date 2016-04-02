function [time,data,window] = ReadData( file_name,lineskp)
%% TXT File read
[time,data] = textread(file_name,'%d%f%*[^\n]','delimiter','\t','headerlines',lineskp);

time = time /60; %convert to minutes

%% Window Intailzed
% window = input('How long is your window (minutes, 0 = smallest window of 30 seconds)? ');
% window = window * 2 %%Each point is 30 seconds thus 2 points/minute
window = 10; % 5 min

end