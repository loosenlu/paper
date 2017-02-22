
nodes_num = 10;
users_num = 100;
x_range = 5;
y_range = 5;
storage_limite = 50;
qos = 5;
objs_num = 150;


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
     analysis_algorithm(user_points, allocated_matrix1, nodes_cost_matrix_without_route, qos);
                             
[nearst_node(1, i), nearst_node(2, i)] = ...
     analysis_algorithm(user_points, allocated_matrix2, nodes_cost_matrix_without_route, qos);
 
 [satisfy_qos(1, i), satisfy_qos(2, i)] = ...
     analysis_algorithm(user_points, allocated_matrix3, nodes_cost_matrix_without_route, qos);

end


hold on
for i = 1 : nodes_num + 1
    plot(node_points(i).x, node_points(i).y, 'ro');
end

for i = 1 : users_num
    plot(user_points(i).x, user_points(i).y, 'b*');
end
hold off
