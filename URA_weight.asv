function w = URA_weight(M, a)

    % Ensure column vector
    a = a(:);

    % Check dimension consistency
    if length(a) ~= M
        error('Dimension mismatch: M must equal length of steering vector.');
    end

    % DAS weight computation
    w = (1/M) * a;

end