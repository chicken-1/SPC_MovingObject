function y = add_noise(x, snr_db)

    signal_power = mean(abs(x(:)).^2);
    snr_linear = 10^(snr_db / 10);
    noise_power = signal_power / snr_linear;
    if isreal(x)
        noise = sqrt(noise_power) * randn(size(x));
    else
        noise = sqrt(noise_power/2) * (randn(size(x)) + 1i * randn(size(x)));
    end
    y = x + noise;
end
