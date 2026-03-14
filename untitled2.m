c  = 3e8;      
fc = 1e9;
lambda = c/fc;
k = 2*pi/lambda;

Nx = 4;
Ny = 4;
d  = lambda/2;

%% Generate random direction
az_deg = -60 + 120*rand;    % [-60 , 60] refer my diagram in whatsapp 
el_deg =  10 +  60*rand;    % [10 , 70] rand is used to generate random values 

fprintf("Random Azimuth   = %.2f deg\n", az_deg);
fprintf("Random Elevation = %.2f deg\n", el_deg);

%% Call function
a = URA_vector(Nx, Ny, d, k, az_deg, el_deg);

disp("Steering vector:");
disp(a);

M = Nx*Ny;
w = URA_weight(M,a);

disp("DAS Beamformer weight")
disp(w);