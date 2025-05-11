function [sparsity, non_zeros] = cal_sparsity(img)
    num_zeros = sum(sum(img == 0));
    img_pixels = size(img, 1)*size(img, 2);
    non_zeros =  img_pixels - num_zeros;
    sparsity = non_zeros/img_pixels;
end