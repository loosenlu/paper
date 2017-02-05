
cache_node_num = 5;
user_num = 5;
obj_num = 10;
limited_time = 3;

[delay_matrix, user_location] = ...
        topology_initialization(cache_node_num, user_num);

user_cost_matrix = get_user_cost_matrix(delay_matrix, user_location);
[min_time, allocation_matrix]= ...
    compute_min_time(user_cost_matrix, obj_num, limited_time);