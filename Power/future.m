function [time,data] = future( time,data,window )

len = length(data);
sd_b = std(data(1:len));
once = true;

%% Predicitive Algorithims

op = input('What predictive method would you like to use? ');
if isempty(op)
    op = 2;
end

for x = 1:window
    if op == 1
        %%EWMA
    data(len+x) = (exp(-.02312))*data(len+(x-1))+(1-exp(-.02312))*data(len+(x-2));
    % look into diffrent constants
%         for i = 0:3
%     data(len+x) = sum((exp(-.02312))*((1-exp(-.02312))^i)*data((len+(i-1))));
%         end
    elseif op == 2
        %%Matrix
        while (once)
        %%Energy Budget
        m = len/window; % number of rows
        m = round(m);
        if isnan(m) || isinf(m)
            m = 5;
        end
        n = input('How many divsion per window would you like to make? ');
        if isempty(n)
            n = 5;
        end
        budget = zeros(m,n);
        z = 1;
        for x1 = 1:m
            for y = 1:n
            budget(x1,y) = data(z);
            z = z + 1;
            end
        end
        once = false;
        end
    data(len+x) = sum(budget(m,1:n))/(n-1) + sum(budget(1:m,n))/(m-1);
    else
        %%Pure Average
    data(len+x) = sum(data(1:len))/len;
    end
    time(len+x) = time(len+(x-1))+.5;
end

%% Error Checking
len = length(data);
sd_a = std(data(1:len));
disp(sd_b - sd_a)

end

