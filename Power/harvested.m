function [ h_energy, h_voltage, E_av] = harvested(data,win)
HT = input('Harvesting Technique Used? ','s');
if isempty(HT)
    HT = 'Solar';
end
l = length(data);
h_energy = zeros(1,l);
h_voltage = zeros(1,l);

% Energey harvested for a given solar panel, In joules
switch HT
    
    case 'Solar'
        area = input('Area of the Solar Cell? (cm^2)');
        if isempty(area)
              area = 40;
        end
        effciency = input('Effcieny of the Solar Cell? (Decmial Form)');
        if isempty(effciency)
              effciency = .07;
        end
        i_sc = input('What is the maximum current provided by solar cell? (A)');
        if isempty(i_sc)
              i_sc = 2; 
        end

    HT_info = struct('area',area,'effciency',effciency);
    
    for x = 1:l
    h_energy(x) = (HT_info.area * HT_info.effciency * data(x));
    h_voltage(x) = (HT_info.area * HT_info.effciency * data(x))/i_sc;
    end
    E_av = sum(h_energy((l-win):l));

    case 'Human Kinetic'
        disp('To be Specified')
% Add Case Statements for more diffrent techniques
    otherwise
        disp('Harvesting TEchnique Not Specified')
        
end

