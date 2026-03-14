function [azimuth,elevation] = csvfile(filename)

clc;
clear;

%% Read STK CSV file
T = readtable('exported_beam.csv',...
    'FileType','text',...
    'Encoding','UTF-16LE',...
    'Delimiter','\t',...
    'ReadVariableNames',false);

%% Extract rows
az_text = T{2,2:end};
el_text = T{3,2:end};

%% Convert to string (important)
az_text = string(az_text);
el_text = string(el_text);

%% Extract degree value
extractDeg = @(x) str2double( ...
    regexp(x,'[-+]?\d+\.?\d*$','match','once'));

%% Convert → LIST FORMAT
azimuth   = arrayfun(extractDeg, az_text);
elevation = arrayfun(extractDeg, el_text);

%% Remove NaN values
azimuth   = azimuth(~isnan(azimuth));
elevation = elevation(~isnan(elevation));

%% Convert to column LISTS
azimuth   = azimuth(:);      % List 1
elevation = elevation(:);    % List 2

%% Display lists
disp('Azimuth List:')
disp(azimuth)

disp('Elevation List:')
disp(elevation)

%% Plot check
figure
plot(azimuth,'LineWidth',2)
title('Azimuth Angle (deg)')
xlabel('Index')
ylabel('Degrees')
grid on

figure
plot(elevation,'LineWidth',2)
title('Elevation Angle (deg)')
xlabel('Index')
ylabel('Degrees')
grid on