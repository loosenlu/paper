

nodes_num = 5;
max_time = 20;
operator_num = 1;
max_users = 100;
max_file_objs = 100;
capacity = 66;

% [network_info, operator_info, cache_info] = ...
%     init_info(nodes_num, max_time, operator_num, max_users, max_file_objs, capacity);


process_info.nodes_num = nodes_num;
process_info.cache_info = cache_info;

for i = 1 : operator_num
    % Get the operator that will process;
    operator = operator_info(i);
    visited_cost_matrix = network_info(operator.user_location, :);
    operator.visited_cost_matrix = visited_cost_matrix;
    
    process_info.operator = operator;
    % TODO
    % ----------------------
    allocated_matrix = get_located_matrix_user_first(process_info);
    [system_visited_time, users_visited_time, storage_usage, users_satisfication] = ... 
            analysis_algorithm(allocated_matrix, operator);
    % ----------------------
end