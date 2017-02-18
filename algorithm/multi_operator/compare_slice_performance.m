function [slices_performance_result] = ...
        compare_slice_performance(delay_matrix, slices_info, limited_space)

    
[~, slices_num] = size(slices_info);
[nodes_num, ~] = size(delay_matrix);

cache_info = generate_cache_info(nodes_num, limited_space);

slices_performance_result = zeros(1, slices_num);

for i = 1 : slices_num
    
    user_cost_matrix = delay_matrix(slices_info(i).users_location, :);
    obj_num = slices_info(i).obj_num;
    limited_time = slices_info(i).limited_time;
    
    [located_matrix, cache_info] = ...
        operator_get_located_matrix_with_balanced(user_cost_matrix, obj_num, limited_time, cache_info)
    
    [visited_time] = acquire_user_time(user_cost_matrix, located_matrix);
    slices_performance_result(i) = ...
        sum(sum(visited_time)) / (obj_num * slices_info(i).users_num);
    
end

