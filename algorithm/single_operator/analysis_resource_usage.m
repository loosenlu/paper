function [usage_matrix] = ...
    analysis_resource_usage(delay_matrix, users_location,  obj_num, limited_time, limited_space)

[~, nodes_num] = size(delay_matrix);
cache_info = generate_cache_info(nodes_num, limited_space);
user_cost_matrix = delay_matrix(users_location, :);


usage_matrix = zeros(3, nodes_num);



[located_matrix_no_balance] = ...
    get_located_matrix_no_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

[located_matrix_with_balance] = ...
    get_located_matrix_with_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

[located_matrix_least_time] = ...
	get_located_matrix_least_time(user_cost_matrix, obj_num, limited_time, cache_info);


usage_matrix(1, :) = sum(located_matrix_least_time) / limited_space;
usage_matrix(2, :) = sum(located_matrix_no_balance) / limited_space;
usage_matrix(3, :) = sum(located_matrix_with_balance) / limited_space;