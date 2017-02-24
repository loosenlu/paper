

nodes_num = 10;
x_range = 5;
y_range = 5;
storage_limit = 50;
% ³õÊ¼»¯ÍøÂçÍØÆË
node_points = generate_node_points(nodes_num, storage_limit, x_range, y_range);
nodes_cost_matrix = get_nodes_cost_matrix(node_points);
nodes_cost_matrix_without_route = zeros(nodes_num + 1, nodes_num + 1);
for i = 1 : nodes_num + 1
    nodes_cost_matrix_without_route(i, :) = ...
                        [nodes_cost_matrix(i, :).cost];
end



% SLICE 1
users_num_1 = 50;
qos_1 = 5;
objs_num_1 = 25;
cache_limit1 = Inf;

user_points_1 = generate_user_points(users_num_1, x_range, y_range);
[user_points_1, node_points] = connect_users_to_nodes(user_points_1, node_points);

[slice1_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_1, node_points, objs_num_1, qos_1, ...
                                 nodes_cost_matrix_without_route);


% SLICE 2
users_num_2 = 80;
qos_2 = 6;
objs_num_2 = 35;
cache_limit2 = Inf;

user_points_2 = generate_user_points(users_num_2, x_range, y_range);
[user_points_2, node_points] = connect_users_to_nodes(user_points_2, node_points);

[slice2_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_2, node_points, objs_num_2, qos_2, ...
                                 nodes_cost_matrix_without_route);



% SLICE 3
users_num_3 = 100;
qos_3 = 8;
objs_num_3 = 35;
cache_limit3 = Inf;

user_points_3 = generate_user_points(users_num_2, x_range, y_range);
[user_points_3, node_points] = connect_users_to_nodes(user_points_3, node_points);

[slice3_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_3, node_points, objs_num_3, qos_3, ...
                                 nodes_cost_matrix_without_route);
                             
                             
                             
% SLICE 4
users_num_4 = 50;
qos_4 = 9;
objs_num_4 = 55;
cache_limit4 = Inf;

user_points_4 = generate_user_points(users_num_4, x_range, y_range);
[user_points_4, node_points] = connect_users_to_nodes(user_points_4, node_points);

[slice4_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_4, node_points, objs_num_4, qos_4, ...
                                 nodes_cost_matrix_without_route);


% SLICE 5
users_num_5 = 80;
qos_5 = 10;
objs_num_5 = 60;
cache_limit5 = Inf;

user_points_5 = generate_user_points(users_num_5, x_range, y_range);
[user_points_5, node_points] = connect_users_to_nodes(user_points_5, node_points);

[slice5_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_5, node_points, objs_num_5, qos_5, ...
                                 nodes_cost_matrix_without_route);



% SLICE 6
users_num_6 = 100;
qos_6 = 11;
objs_num_6 = 65;
cache_limit6 = Inf;

user_points_6 = generate_user_points(users_num_6, x_range, y_range);
[user_points_6, node_points] = connect_users_to_nodes(user_points_6, node_points);

[slice6_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_6, node_points, objs_num_6, qos_6, ...
                                 nodes_cost_matrix_without_route);

                             
% SLICE 7
users_num_7 = 50;
qos_7 = 12;
objs_num_7 = 60;
cache_limit7 = Inf;

user_points_7 = generate_user_points(users_num_7, x_range, y_range);
[user_points_7, node_points] = connect_users_to_nodes(user_points_7, node_points);

[slice7_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_7, node_points, objs_num_7, qos_7, ...
                                 nodes_cost_matrix_without_route);


% SLICE 8
users_num_8 = 80;
qos_8 = 20;
objs_num_8 = 100;
cache_limit8 = Inf;

user_points_8 = generate_user_points(users_num_8, x_range, y_range);
[user_points_8, node_points] = connect_users_to_nodes(user_points_8, node_points);

[slice8_allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points_8, node_points, objs_num_8, qos_8, ...
                                 nodes_cost_matrix_without_route);


                                  
    
                             
[visited_time_1, users_satisfication_1] = ... 
            analysis_algorithm_time_satisfication(user_points_1, slice1_allocated_matrix, nodes_cost_matrix_without_route, qos_1);
        
[visited_time_2, users_satisfication_2] = ... 
            analysis_algorithm_time_satisfication(user_points_2, slice2_allocated_matrix, nodes_cost_matrix_without_route, qos_2);
        
[visited_time_3, users_satisfication_3] = ... 
            analysis_algorithm_time_satisfication(user_points_3, slice3_allocated_matrix, nodes_cost_matrix_without_route, qos_3);
 
[visited_time_4, users_satisfication_4] = ... 
            analysis_algorithm_time_satisfication(user_points_4, slice1_allocated_matrix, nodes_cost_matrix_without_route, qos_4);
        
[visited_time_5, users_satisfication_5] = ... 
            analysis_algorithm_time_satisfication(user_points_5, slice2_allocated_matrix, nodes_cost_matrix_without_route, qos_5);
        
[visited_time_6, users_satisfication_6] = ... 
            analysis_algorithm_time_satisfication(user_points_6, slice3_allocated_matrix, nodes_cost_matrix_without_route, qos_6);


[visited_time_7, users_satisfication_7] = ... 
            analysis_algorithm_time_satisfication(user_points_7, slice7_allocated_matrix, nodes_cost_matrix_without_route, qos_7);
        
[visited_time_8, users_satisfication_8] = ... 
            analysis_algorithm_time_satisfication(user_points_6, slice3_allocated_matrix, nodes_cost_matrix_without_route, qos_8);




