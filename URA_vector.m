function a = URA_vector(Nx, Ny, d, lambda, az_deg, el_deg)

    % Convert to radians
    az = deg2rad(az_deg);
    el = deg2rad(el_deg);

    % Wavenumber
    k = 2*pi/lambda;

    % Centered element coordinates
    [xpos, ypos] = meshgrid(-(Nx-1)/2:(Nx-1)/2, ...
                            -(Ny-1)/2:(Ny-1)/2);

    xpos = xpos(:) .* d;
    ypos = ypos(:) .* d;

    % Direction cosines
    ux = sin(el).*cos(az);
    uy = sin(el).*sin(az);

    % Steering vector
    a = exp(1j * k * (xpos.*ux + ypos.*uy));

end
