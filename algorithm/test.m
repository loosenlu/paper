
user_number = 20;
cache_node_num = 10;
cache_limit = 50;
obj_number = 100;

max_time = 20;
limited_time = 5;

[delay_matrix, user_location] = topology_initialization(cache_node_num, user_number, max_time);
[user_cost_matrix] = get_user_cost_matrix(delay_matrix, user_location);
[cache_info] = generate_cache_info(cache_node_num, cache_limit);

        
[located_matrix_no_balance] = ...
    get_located_matrix_no_balanced(user_cost_matrix, obj_number, limited_time, cache_info);

[located_matrix_with_balance] = ...
    get_located_matrix_with_balanced(user_cost_matrix, obj_number, limited_time, cache_info);

[located_matrix_least_time] = ...
    get_located_matrix_least_time(user_cost_matrix, obj_number, limited_time, cache_info);

[visited_time_no_balance] = acquire_user_time(user_cost_matrix, located_matrix_no_balance);
[visited_time_with_balance] = acquire_user_time(user_cost_matrix, located_matrix_with_balance);
[visited_time_least_time] = acquire_user_time(user_cost_matrix, located_matrix_least_time);

sa_no_balance = sum(visited_time_no_balance <= limited_time, 2);
sa_with_balance = sum(visited_time_with_balance <= limited_time, 2);
sa_least_time = sum(visited_time_least_time <= limited_time, 2);

resource_usage_no_balance = sum(located_matrix_no_balance);
resource_usage_with_balance = sum(located_matrix_with_balance);
resource_usage_least_time = sum(located_matrix_least_time);


