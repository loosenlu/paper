function [sys_time_result, users_visited_time] = ...
    analysis_sys_info_from_obj(delay_matrix, users_location, max_obj_num, user_num, limited_time, limited_space)


[nodes_num, ~] = size(delay_matrix);
cache_info = generate_cache_info(nodes_num, limited_space);

needed_users_location = users_location(1:user_num);
user_cost_matrix = delay_matrix(needed_users_location, :);

sys_time_result = zeros(3, max_obj_num);
users_visited_time = zeros(3, max_obj_num);


for i = 1 : max_obj_num
  
    [located_matrix_no_balance] = ...
        get_located_matrix_no_balanced(user_cost_matrix, i, limited_time, cache_info);

    [located_matrix_with_balance] = ...
        get_located_matrix_with_balanced(user_cost_matrix, i, limited_time, cache_info);

    [located_matrix_least_time] = ...
        get_located_matrix_least_time(user_cost_matrix, i, limited_time, cache_info);

    [visited_time_no_balance] = acquire_user_time(user_cost_matrix, located_matrix_no_balance);
    [visited_time_with_balance] = acquire_user_time(user_cost_matrix, located_matrix_with_balance);
    [visited_time_least_time] = acquire_user_time(user_cost_matrix, located_matrix_least_time);
    
    sys_time_result(1, i) = sum(sum(visited_time_least_time));
    sys_time_result(2, i) = sum(sum(visited_time_no_balance));
    sys_time_result(3, i) = sum(sum(visited_time_with_balance));
    
    
    users_visited_time(:, i) = sys_time_result(:, i) / (i * user_num);
    
end




