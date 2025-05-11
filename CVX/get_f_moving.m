function f = get_f_moving(type,img, pixel_size, movement, f_cam, meas)
%GET_F_MOVING create a moving object and take measurements
% type: 1: linear moving, 2: diagonal moving, 3: oscillation
if type == 1
    f = get_f_linear(img, pixel_size, movement, f_cam);
elseif type == 2
    f = get_f_diagonal(img, pixel_size, movement, f_cam);
elseif type == 3
    f = get_f_oscillation(img, meas, pixel_size, movement, f_cam);
else
    f = 0;
end