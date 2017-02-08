function [sys_time_result] = ...
    analysis_sys_time(user_cost_matrix, max_obj_number, limited_time, cache_info)


sys_time_result = zeros(3, max_obj_number);

for i = 1 : max_obj_number
  
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
    
end




