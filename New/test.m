
nodes_num = 10;
users_num = 100;
x_range = 5;
y_range = 5;
storage_limite = 50;
qos = 5;
objs_num = 200;

observation_index = 168;


node_points = generate_node_points(nodes_num, storage_limite, x_range, y_range);
user_points = generate_user_points(users_num, x_range, y_range);

[user_points, node_points] = connect_users_to_nodes(user_points, node_points);

nodes_cost_matrix = get_nodes_cost_matrix(node_points);
nodes_cost_matrix_without_route = zeros(nodes_num + 1, nodes_num + 1);
for i = 1 : nodes_num + 1
    nodes_cost_matrix_without_route(i, :) = ...
                        [nodes_cost_matrix(i, :).cost];
end

along_route = zeros(2, objs_num);
nearst_node = zeros(2, objs_num);
satisfy_qos = zeros(2, objs_num);
for i = 1 : objs_num

[allocated_matrix1, ~] = ...
    allocate_storage_along_route(nodes_cost_matrix, i, ...
                                 user_points, node_points);
                             
                             
[allocated_matrix2, ~] = ...
    allocate_storage_nearst_node(nodes_cost_matrix, i, ...
                                 user_points, node_points);
                             

[allocated_matrix3, ~] = ...
    allocate_storage_satisfy_qos(user_points, node_points, i, qos, ...
                                 nodes_cost_matrix_without_route);
                             


[along_route(1, i), along_route(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points, allocated_matrix1, nodes_cost_matrix_without_route, qos);
                             
[nearst_node(1, i), nearst_node(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points, allocated_matrix2, nodes_cost_matrix_without_route, qos);
 
 [satisfy_qos(1, i), satisfy_qos(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points, allocated_matrix3, nodes_cost_matrix_without_route, qos);

end

[redundancy_route, storage_usage_route] = ... 
            analysis_algorithm_storage(allocated_matrix1, storage_limite, observation_index);
        
[redundancy_nearst, storage_usage_nearst] = ... 
            analysis_algorithm_storage(allocated_matrix2, storage_limite, observation_index);

[redundancy_satisfication, storage_usage_satisfication] = ... 
            analysis_algorithm_storage(allocated_matrix3, storage_limite, observation_index);

along_route_user = zeros(2, users_num);
nearst_node_user = zeros(2, users_num);
satisfy_qos_user = zeros(2, users_num);
for i = 1 : users_num

 user_points_now = user_points(1:i);
    
[allocated_matrix1, ~] = ...
    allocate_storage_along_route(nodes_cost_matrix, 100, ...
                                 user_points_now, node_points);
                                                          
[allocated_matrix2, ~] = ...
    allocate_storage_nearst_node(nodes_cost_matrix, 100, ...
                                 user_points_now, node_points);
                             
[allocated_matrix3, ~] = ...
    allocate_storage_satisfy_qos(user_points_now, node_points, 100, qos, ...
                                 nodes_cost_matrix_without_route);
                             

[along_route_user(1, i), along_route_user(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points_now, allocated_matrix1, nodes_cost_matrix_without_route, qos);
                             
[nearst_node_user(1, i), nearst_node_user(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points_now, allocated_matrix2, nodes_cost_matrix_without_route, qos);
 
[satisfy_qos_user(1, i), satisfy_qos_user(2, i)] = ...
     analysis_algorithm_time_satisfication(user_points_now, allocated_matrix3, nodes_cost_matrix_without_route, qos);
 
end



% hold on
% for i = 1 : nodes_num + 1
%     plot(node_points(i).x, node_points(i).y, 'ro');
% end
% 
% for i = 1 : users_num
%     plot(user_points(i).x, user_points(i).y, 'b*');
% end
% hold off
