function f = get_f_oscillation(img, m, pixel_size, f_ob, f_cam)
%GET_F_OSCILLATION create a oscillation moving object and take measurements
    %parameters
    amplitude = 10;
    center = (30+40)/2; % the center of the object
    f = img(:);

    for t = 1:m
        cur_pos = amplitude*sin(2*pi*f_ob*double(t)/double(f_cam)) + center;

        % draw the object at the new position
        r_edge = cur_pos + 4.5;
        l_edge = cur_pos - 4.5;
        r_edge_gradient = (r_edge - floor(r_edge))*255;
        l_edge_gradient = (ceil(l_edge) - l_edge)*255;
        img = zeros(64, 64);
        for i = 30:40
            for j = floor(l_edge):ceil(r_edge)
                if j == floor(l_edge)
                    img(i, j) = l_edge_gradient;
                elseif j == ceil(r_edge)
                    img(i, j) = r_edge_gradient;
                else
                    img(i, j) = 255;
                end
            end
        end
        f = [f, img(:)];
    end
end