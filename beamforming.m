% Code used to start Ansys STK from MATLAB then add components to it using
% Childern.New command
uiapp = actxserver('STK11.Application');
uiapp.Visible = 1;
root = uiapp.Personality2;
root.NewScenario('BeamSteeringScenario');
scenario = root.CurrentScenario;
root.Rewind;
gs = scenario.Children.New('eFacility','GroundStation');
gs.Position.AssignGeodetic(13.0827, 80.2707, 0);
sat = scenario.Children.New('eSatellite','LEO_Sat');
gsTx = gs.Children.New('eTransmitter','GS_Tx');
gsRx = gs.Children.New('eAntenna','GS_Ant');
satTx = sat.Children.New('eTransmitter','Sat_Tx');
satRx = sat.Children.New('eAntenna','Sat_Ant');



% fresh envi for launching aer function
startTime = datetime(2026,4,28,12,0,0);
stopTime  = startTime + hours(1);

sc = satelliteScenario(startTime, stopTime, 60);
sat = satellite(sc, ...
    7000e3, ...        % semi-major axis (m)
    0.001, ...         % eccentricity
    98, ...            % inclination (deg)
    0, ...             % RAAN
    0, ...             % argument of perigee
    0);                % true anomaly
gs = groundStation(sc, 10, 78);  % lat, lon (deg)

%% Get Azimuth & Elevation
[az, el] = aer(gs, sat); % function that is used to get the azimuth and elevation from STK 
azimuth   = az(:);    
elevation = el(:);   
c  = 3e8;      
fc = 1e9;
lambda = c/fc;
k = 2*pi/lambda;
Nx = 4;
Ny = 4;
d  = lambda/2;
N = numel(azimuth);

sum_values = zeros(N,1);

for i = 1:N
    a = URA_vector(Nx, Ny, d, k, azimuth(i), elevation(i));
end
disp ("Steering Vector computed from values generated in Ansys STK  a(theta) ")
disp(a)

M = Nx*Ny
w = URA_weight(M,a);
disp("DAS Weight  W= (1/M)*a ")
disp(w);

% IQ Samples from BladeRF xA4 ( got it using bladeRF-cli )

data = readtable('mimo.csv');
I = data{:,1};
Q = data{:,2};

s = I + 1i*Q;      % complex SDR signal

snapshot = 1000;
x = a .* s(snapshot);
disp('Input Signal from BladeRF xA4')
disp (x);

% Beamformer output
y = DAS_Beamformer(w, x);
disp("DAS Beamformer Output:   Y = W^H * X ");
disp(y);

% --- Choose steering direction (example: first STK angle)
theta0 = azimuth(1);
phi0   = elevation(1);

% Compute steering vector for desired direction
a0 = URA_vector(Nx, Ny, d, lambda, theta0, phi0);

M = Nx * Ny;
w = URA_weight(M, a0);

% --- Create 3D Scan Grid
az_scan = -180:3:180;     % azimuth sweep
el_scan = -90:3:90;       % elevation sweep

[az_grid, el_grid] = meshgrid(az_scan, el_scan);

P = zeros(size(az_grid));  % Beam pattern storage

% --- Compute Beam Pattern from using only one particular angle from the satellite position 
for ii = 1:numel(az_grid)
    
    a_test = URA_vector(Nx, Ny, d, lambda, ...
                        az_grid(ii), el_grid(ii));
    
    P(ii) = abs(w' * a_test);   % |w^H a|
    
end

P = P ./ max(P(:)); 
P_dB = 20*log10(P + 1e-12);   % avoid log(0)

figure;
surf(az_grid, el_grid, P_dB, 'EdgeColor','none');
colormap jet;
colorbar;
xlabel('Azimuth (deg)');
ylabel('Elevation (deg)');
zlabel('Magnitude (dB)');
title(['3D DAS Beam Pattern | Steered to Az=', ...
       num2str(theta0), ', El=', num2str(phi0)]);
view(45,30);







