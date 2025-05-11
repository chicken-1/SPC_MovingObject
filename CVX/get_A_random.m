function A = get_A_random(n, m)
%% This function create binary random matrix %%

% Initialize the matrix
A = zeros(m, n);

% Fill the matrix ensuring no full zero rows and columns
while true
    % Generate a random matrix with values between 0 and 1
    A = randi([0, 1], m, n); % Random integers (0 or 1)
    
    % Check if there are any full zero rows or columns
    if all(any(A, 1)) && all(any(A, 2))
        break; % Exit the loop if no full zero rows or columns
    end
end
end
