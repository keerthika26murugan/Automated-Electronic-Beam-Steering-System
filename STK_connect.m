clc; clear;

uiapp = actxserver('STK11.Application');
uiapp.Visible = 1;
root = uiapp.Personality2;
root.NewScenario('BeamSteeringScenario');
scenario = root.CurrentScenario;
root.Rewind;



gs = scenario.Children.New('eFacility','GroundStation');
gs.Position.AssignGeodetic(13.0827, 80.2707, 0);
sat = scenario.Children.New('eSatellite','LEO_Sat');

%% Create Scenario
startTime = datetime(2026,4,28,12,0,0);
stopTime  = startTime + hours(1);

sc = satelliteScenario(startTime, stopTime, 60);

%% Add Satellite (TLE or Keplerian)
sat = satellite(sc, ...
    7000e3, ...        % semi-major axis (m)
    0.001, ...         % eccentricity
    98, ...            % inclination (deg)
    0, ...             % RAAN
    0, ...             % argument of perigee
    0);                % true anomaly

%% Add Ground Station
gs = groundStation(sc, 10, 78);  % lat, lon (deg)

%% Get Azimuth & Elevation
[az, el] = aer(gs, sat);

%% Display
disp("Azimuth:")
disp(az)

disp("Elevation:")
disp(el)




