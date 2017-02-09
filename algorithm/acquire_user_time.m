function [user_visited_time] = acquire_user_time(user_cost_matrix, located_matrix)


[user_num, ~] = size(user_cost_matrix);
[obj_num, ~] = size(located_matrix);

user_visited_time = zeros(user_num, obj_num);

for i = 1 : user_num
    
    visited_time_vector = user_cost_matrix(i, :);
    for j = 1 : obj_num
        located_index = find(located_matrix(j, :) ~= 0);
        if isempty(located_index) ~= 1
            user_visited_time(i, j) = ...
                min(visited_time_vector(located_index));
        end
    end
end