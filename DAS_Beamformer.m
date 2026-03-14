function y = DAS_Beamformer(w, x)
% DAS Beamformer
% y = w^H * x

    % Ensure column vectors
    w = w(:);
    x = x(:);

    % Dimension check
    if length(w) ~= length(x)
        error('w and x must have same length');
    end

    % DAS output
    y = w' * x;   % w^H x (MATLAB ' does conjugate transpose)

end