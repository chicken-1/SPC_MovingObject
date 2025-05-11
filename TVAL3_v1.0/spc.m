clear; close all;
path(path,genpath(pwd));
fullscreen = get(0,'ScreenSize');

% problem size
n = 64;
ratio = .3;
p = n; q = n; % p x q is the size of image
m = round(ratio*n^2);

% sensing matrix
A = rand(m,p*q);

% original image
img = zeros(64, 64);

% parameters
pixel_size = 0.1; %mm
v_ob = 12; %mm/s object's velocity on screen
f_cam = 5000; % meas/s: taking measurements frequency of camera
f_ob = 10000;

I = get_f_moving(1, img, pixel_size, v_ob, f_cam);

snr_db = [60];
for j=1:length(snr_db)
% observation
for i=1:size(A, 1)
    if i <= size(I, 2)
        I_noisy = add_noise(I(:, i), snr_db(j));
        f(i, 1) = A(i, :)*I_noisy;
    else
        I_noisy = add_noise(I(:, end), snr_db(j));
        f(i, 1) = A(i, :)*I_noisy;
    end
end
% f = A*img;

% add noise

% f_noisy = add_noise(f, snr_db(j));


%% Run 0

clear opts
opts.mu = 2^8;
opts.beta = 2^5;
opts.tol = 1E-3;
opts.maxit = 300;
opts.TVnorm = 1;
opts.nonneg = true;

t = cputime;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
[U, out] = TVAL3(A,f,p,q,opts);
t = cputime - t;

figure;
imshow(U, [], 'InitialMagnification', 'fit');
saveas(gcf, sprintf("result_TVAL/sysnoise_%d_%ddb.jpg", v_ob, snr_db(j)));
end
% saveas(gcf, sprintf("result_TVAL/oscillation_%d_%dk.jpg", f_ob, f_cam/1000));
% xlabel(sprintf(' %2d%% measurements \n Rel-Err: %4.2f%%, CPU: %4.2fs ',ratio*100,norm(U-I,'fro')/nrmI*100,t),'fontsize',16);
