function f = get_f_oscillation(img, m, pixel_size, f_cam, f_ob)
%     v_pixel = v_ob*1/f_cam/pixel_size; % distance moved in pixel after a measurement
% 
%     %parameters
%     amplitude = 10;
%     center = (32+41)/2; % the center of the object
%     bound_r = center + amplitude;
%     bound_l = center - amplitude;
%     direction_f = 1; % 1: moving to the right, 0: left
%     prev_pos = center;
%     f = img(:);
% 
% 
%     for t = 1:m
% 
%         % move
%         if direction_f == 1
%             cur_pos = prev_pos + v_pixel;
%         else
%             cur_pos = prev_pos - v_pixel;
%         end
% 
%         % calculate center position
%         if cur_pos >= bound_r
%             cur_pos = bound_r - (cur_pos - bound_r);
%             direction_f = 0;
%         elseif cur_pos <= bound_l
%             cur_pos = bound_l + (bound_l - cur_pos);
%             direction_f = 1;
%         end
% 
%         % draw the object at the new position
%         r_edge = cur_pos + 4.5;
%         l_edge = cur_pos - 4.5;
%         r_edge_gradient = (r_edge - floor(r_edge))*255;
%         l_edge_gradient = (ceil(l_edge) - l_edge)*255;
%         img = zeros(64, 64);
%         for i = 30:41
%             for j = floor(l_edge):ceil(r_edge)
%                 if j == floor(l_edge)
%                     img(i, j) = l_edge_gradient;
%                 elseif j == ceil(r_edge)
%                     img(i, j) = r_edge_gradient;
%                 else
%                     img(i, j) = 255;
%                 end
%             end
%         end
% 
%         prev_pos = cur_pos;
%         f = [f, img(:)];
%     end

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