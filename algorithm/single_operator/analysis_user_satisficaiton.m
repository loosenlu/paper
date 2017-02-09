function [users_satisfication_result] = ...
    analysis_user_satisficaiton(delay_matrix, users_location, obj_num, max_user_num, limited_time, limited_space, satisfication)


[nodes_num, ~] = size(delay_matrix);
cache_info = generate_cache_info(nodes_num, limited_space);


users_satisfication_result = zeros(3, max_user_num);


for i = 1 : max_user_num
    
    needed_users_location = users_location(1:i);
    user_cost_matrix = delay_matrix(needed_users_location, :);
    
    [located_matrix_no_balance] = ...
        get_located_matrix_no_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

    [located_matrix_with_balance] = ...
        get_located_matrix_with_balanced(user_cost_matrix, obj_num, limited_time, cache_info);

    [located_matrix_least_time] = ...
        get_located_matrix_least_time(user_cost_matrix, obj_num, limited_time, cache_info);

    [visited_time_no_balance] = acquire_user_time(user_cost_matrix, located_matrix_no_balance);
    [visited_time_with_balance] = acquire_user_time(user_cost_matrix, located_matrix_with_balance);
    [visited_time_least_time] = acquire_user_time(user_cost_matrix, located_matrix_least_time);
    
    temp_sa_matrix = zeros(i, 3);
    temp_sa_matrix(:, 1) = sum(visited_time_least_time <= limited_time, 2) / obj_num;
    temp_sa_matrix(:, 2) = sum(visited_time_no_balance <= limited_time, 2) / obj_num;
    temp_sa_matrix(:, 3) = sum(visited_time_with_balance <= limited_time, 2) / obj_num;
    
    
    users_satisfication_result(:, i) = (sum(temp_sa_matrix >= satisfication) / i)';
    
end