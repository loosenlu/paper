
nodes_num = 10;
users_num = 100;
x_range = 5000;
y_range = 5000;
storage_limite = 50;


node_points = generate_node_points(nodes_num, storage_limite, x_range, y_range);
user_points = generate_user_points(users_num, x_range, y_range);

[user_points, node_points] = connect_users_to_nodes(user_points, node_points);

nodes_cost_matrix = get_nodes_cost_matrix(node_points);


[allocated_matrix] = ...
    allocate_storage_along_route(nodes_cost_matrix, 100, ...
                                 user_points, node_points);
                             
                             
 

% hold on
% for i = 1 : nodes_num
%     plot(node_points(i).x, node_points(i).y, 'ro');
% end
% 
% for i = 1 : users_num
%     plot(user_points(i).x, user_points(i).y, 'b*');
% end
% hold off
