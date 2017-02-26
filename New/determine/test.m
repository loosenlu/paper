
nodes_num = 50;
x_range = 50;
y_range = 50;
storage_limit = 50;

node_points = generate_node_points(nodes_num, storage_limit, x_range, y_range);
[nodes_cost_matrix, nodes_topology] = get_nodes_cost_matrix(node_points);
nodes_cost_matrix_without_route = zeros(nodes_num + 1, nodes_num + 1);

for i = 1 : nodes_num + 1
    nodes_cost_matrix_without_route(i, :) = ...
                        [nodes_cost_matrix(i, :).cost];
end