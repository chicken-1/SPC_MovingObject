function f = get_f_moving(img, pixel_size, v_ob, f_cam)

f = img(:);

ob_r_edge = 11; % the right edge of object is in the 11th column
cur_r_edge = ob_r_edge;
l_edge = cur_r_edge - 10;
s_pixel = v_ob*1/f_cam/pixel_size; % distance moved in pixel in 1 seconds

while cur_r_edge < 74
    img = zeros(64, 64);
    prev_r_edge = cur_r_edge;
    cur_r_edge = prev_r_edge + s_pixel;
    l_edge = cur_r_edge - 10;
    if l_edge <= 64
    r_edge_int = ceil(cur_r_edge);
    l_edge_int = floor(l_edge);

    gradient_rate_l = double(r_edge_int) - cur_r_edge;
    gradient_l = gradient_rate_l*255;
    gradient_r = (1-gradient_rate_l)*255;
    for i = 30:41  
        if r_edge_int <=64
            img(i, r_edge_int) = gradient_r;
        else
            r_edge_int = 65;
        end
        img(i, l_edge_int) = gradient_l;
        for j = (l_edge_int + 1):(r_edge_int - 1)
            img(i, j) = 255;
        end
    end
    end
    f = [f, img(:)];
end
end