clc
clear all
close all


% create an image with an object
img = zeros(64, 64);
for i = 30:40
    for j = 30:40
        img(i, j) = 255;
    end
end

pixel_size = 0.1; %mm
v_ob = 12; %mm/s object's velocity on screen
f_cam = 5000; % meas/s: taking measurements frequency of camera

[sparsity, non_zeros] = cal_sparsity(img);
% convex parameter
n = size(img, 1)*size(img, 2);
m = 1500;

snr_db = [30, 40, 50, 60];
for j = 1:length(snr_db)
% f_ob = 4;
% f = get_f_oscillation(img, m, pixel_size, f_cam, f_ob);
f = get_f_moving(img, pixel_size, v_ob, f_cam);
% f = get_f_diagonal(img, pixel_size, v_ob, f_cam);

A = get_A_random(n, m);

% get measurements
for i=1:size(A, 1)
    if i <= size(f, 2)
        f_noisy = add_noise(f(:, i), snr_db(j));
        y(i, 1) = A(i, :)*f_noisy;
    else
        f_noisy = add_noise(f(:, end), snr_db(j));
        y(i, 1) = A(i, :)*f_noisy;
    end
end

% create noise

% y_noisy = add_noise(y, snr_db(i));


% cvx
cvx_begin
    variable xp(n);
    minimize(norm(xp, 1));
    subject to
        A * xp == y;
cvx_end

norm(img(:)-xp)/norm(img(:))
img_rec = reshape(xp, [size(img, 1) size(img, 2)]);

% simulation motion of object
% figure(2),
% for i=1:10
%     disp_img = uint8(reshape(f(:, i*20), 64, 64));
%     subplot(2, 5, i);
%     imshow(disp_img);
% end

% display recovered result
figure(j), sgtitle(sprintf("snr = %d", snr_db(j)));
subplot(1, 2, 1); imshow(uint8(img)); title('Object');
subplot(1, 2, 2); imshow(uint8(img_rec)); title('Recovered result');
saveas(gcf, sprintf("error/snr=%d,v=%d.jpg", snr_db(j), v_ob));
end
% subplot(1, 3, 3); imshow(rgb_img_rec);
% 

% resultsTable = table((1:numIterations)', exe_times, ...
%                      'VariableNames', {'Iteration', 'ExecutionTime'});
% filename = 'cvx_result_v8_li.xlsx';
% writetable(resultsTable, filename);