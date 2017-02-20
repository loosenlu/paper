function [nodes_cost_matrix] = get_nodes_cost_matrix(node_points)

%
% nodes_points: 表示网络中的缓存节点+数据源节点


nodes_distance_matrix = ...
    compute_nodes_ideal_distance_matrix(node_points);
connected_gragh = create_connected_graph(node_points);

nodes_distance_matrix(connected_gragh == 0) = inf;

nodes_cost_matrix = nodes_distance_matrix / 1000;
nodes_cost_matrix(logical(eye(size(nodes_cost_matrix)))) = 1;



% ----------------------------------------------
function [nodes_distance_matrix] = ...
        compute_nodes_ideal_distance_matrix(node_points)

[~, nodes_num] = size(node_points);
nodes_distance_matrix = zeros(nodes_num, nodes_num);

for i = 1 : nodes_num
    for j = 1 : nodes_num
        nodes_distance_matrix(i, j) = ...
            compute_distance(node_points(i), node_points(j));
    end
end

% 找出几个离数据源较近的节点与数据源相连; 
% 其余的均为inf,即不相连；
connected_to_data_node_num = fix(randi(nodes_num - 1 / 2));

distance_to_data_node = ones(nodes_num, nodes_num) * inf;
for i = 2 : nodes_num
    distance_to_data_node(2) = ...
        compute_distance(node_points(i), node_points(1));
end

[~, order] = sort(distance_to_data_node);
for i = connected_to_data_node_num : nodes_num
    nodes_distance_matrix(1, order(i)) = inf;
    nodes_distance_matrix(order(i), 1) = inf;
end



% --------------------------------------------------
function [distance] = compute_distance(point_a, point_b)

% 计算两点间的距离
distance = ((point_a.x - point_b.x)^2 + (point_b.x - point_b.y)^2)^0.5;



% --------------------------------------------------
function [connected_graph] = create_connected_graph(node_points)

% 

[~, nodes_num] = size(node_points);
connected_graph = randi(2, nodes_num, nodes_num) - 1;
connected_graph = tril(connected_graph, -1) + triu(connected_graph, 1);


random_sequence = randperm(nodes_num);

for i = 1 : nodes_num - 1
    connected_graph(random_sequence(i), random_sequence(i + 1)) = 1;
    connected_graph(random_sequence(i + 1), random_sequence(i)) = 1;
end










