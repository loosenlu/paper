function [average_visited_time, users_satisfication] = ... 
            analysis_algorithm(user_points, allocated_matrix, visited_cost_matrix, qos)

[~, users_num] = size(user_points);
[objs_num, ~] = size(allocated_matrix);

users_really_visited_time = zeros(users_num, objs_num);

for i = 1 : users_num
    ith_visited_cost_vector = ...
        visited_cost_matrix(user_points(i).connected_node_id,:);
    for j = 1 : objs_num
        users_really_visited_time(i, j) = ...
                min(ith_visited_cost_vector(allocated_matrix(j, :) ~= 0));
    end
end


average_visited_time = sum(sum(users_really_visited_time)) / (users_num * objs_num);
users_satisfication_percent = ...
    sum(users_really_visited_time <= qos, 2) / objs_num;
% 满意率高于90%的用户数
users_satisfication = sum(users_satisfication_percent >= 0.8) / users_num;


