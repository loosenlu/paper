function [user_satisfication] = ...
    analysis_user_satisfication(user_cost_matrix, max_obj_number, limited_time, cache_info, threshold)


user_satisfication = zeros(3, max_obj_number);
[user_num, ~] = size(user_cost_matrix);

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
    
    sa_least_time = sum(sum(visited_time_least_time <= limited_time, 2) / i >= threshold) / user_num;
    sa_no_balance = sum(sum(visited_time_no_balance <= limited_time, 2) / i >= threshold) / user_num;
    sa_with_balance = sum(sum(visited_time_with_balance <= limited_time, 2) / i >= threshold) / user_num;

    
    user_satisfication(1, i) = sa_least_time;
    user_satisfication(2, i) = sa_no_balance;
    user_satisfication(3, i) = sa_with_balance;
    
end