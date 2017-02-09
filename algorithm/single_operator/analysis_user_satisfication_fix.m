function [user_satisfication_matrix] = ...
    analysis_user_satisfication_fix(delay_matrix, users_location, obj_num, limited_time, limited_space, satisfication)

[~, nodes_num] = size(delay_matrix);
[~, users_num] = size(users_location);

cache_info = generate_cache_info(nodes_num, limited_space);
user_cost_matrix = delay_matrix(users_location, :);


user_satisfication_matrix = zeros(3, users_num);



[located_matrix_no_balance] = ...
    get_located_matrix_no_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

[located_matrix_with_balance] = ...
    get_located_matrix_with_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

[located_matrix_least_time] = ...
	get_located_matrix_least_time(user_cost_matrix, obj_num, limited_time, cache_info);


[visited_time_no_balance] = acquire_user_time(user_cost_matrix, located_matrix_no_balance);
[visited_time_with_balance] = acquire_user_time(user_cost_matrix, located_matrix_with_balance);
[visited_time_least_time] = acquire_user_time(user_cost_matrix, located_matrix_least_time);


user_satisfication_matrix(1, :) = (sum(visited_time_least_time <= limited_time, 2) / obj_num)';
user_satisfication_matrix(2, :) = (sum(visited_time_no_balance <= limited_time, 2) / obj_num)';
user_satisfication_matrix(3, :) = (sum(visited_time_with_balance <= limited_time, 2) / obj_num)';