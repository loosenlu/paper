function [user_cost_matrix] = ...
            get_user_cost_matrix(delay_matrix, user_location)

% get user cost matrix

[~, user_number] = size(user_location);
[~, cache_code_number] = size(delay_matrix);
user_cost_matrix = zeros(user_number, cache_code_number);

for i = 1:user_number
    user_cost_matrix(i, :) = delay_matrix(user_location(i), :);
end