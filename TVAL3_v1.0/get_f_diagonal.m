function f = get_f_diagonal(img, pixel_size, v_ob, f_cam)
%GET_F_DIAGONAL_MOVING create a diagonally moving object and take measurements

f = img(:);

% Initial positions of the object
ob_r_edge = 11; % the right edge of the object starts at the 11th column
ob_b_edge = 11; % the bottom edge of the object starts at the 11th row
cur_r_edge = ob_r_edge;
cur_b_edge = ob_b_edge;
s_pixel = v_ob * 1 / f_cam / pixel_size; % distance moved in pixel in 1 second

while cur_r_edge < 74 && cur_b_edge < 74
    img = zeros(64, 64); % Create a new blank image
    prev_r_edge = cur_r_edge;
    prev_b_edge = cur_b_edge;
    
    % Update the current edges based on diagonal movement
    cur_r_edge = prev_r_edge + s_pixel; % Move right
    cur_b_edge = prev_b_edge + s_pixel; % Move down
    
    % Calculate left and right edges
    l_edge = cur_r_edge - 10; % Left edge
    r_edge = cur_r_edge;       % Right edge
    t_edge = cur_b_edge - 10;
    b_edge = cur_b_edge;

    r_edge_int = ceil(r_edge);
    l_edge_int = floor(l_edge);
    b_edge_int = ceil(b_edge);
    t_edge_int = floor(t_edge);

    % Calculate gradients for smooth transition
    gradient_rate_l = double(r_edge_int) - cur_r_edge;
    gradient_l = gradient_rate_l * 255;
    gradient_r = (1 - gradient_rate_l) * 255;
    gradient_rate_t = double(b_edge_int) - cur_b_edge;
    gradient_t = gradient_rate_t * 255;
    gradient_b = (1 - gradient_rate_t) * 255;

    for i = t_edge_int:min(64, b_edge_int)
        for j = l_edge_int:min(64, r_edge_int)
            img(i, j) = 255;
            img(t_edge_int, j) = gradient_t;
            img(i, l_edge_int) = gradient_l;
            if b_edge_int <= 64
                img(b_edge_int, j) = gradient_b;
            end
            if r_edge_int <=64
                img(i, r_edge_int) = gradient_r;
            end
        end
    end    
    f = [f, img(:)]; % Append the current image to the output vector
end
end