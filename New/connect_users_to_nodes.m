function [user_points, node_points] = ...
    connect_users_to_nodes(user_points, node_points)

% 获取当前用户的连接情况, 即用户连接到哪一个节点上；
% user会连接到与其最近的缓存节点(不包括数据源节点)；

% user_points: 表示用户的位置；
% node_points: 表示缓存节点的位置；

[~, nodes_num] = size(node_points);
[~, users_num] = size(user_points);

% for i = 1 : users_num
%     min_distance_node_id = 0;
%     min_distance = Inf;
%     for j = 2 : nodes_num
%         tmp_distance = compute_distance(user_points(i), node_points(j));
%         if tmp_distance < min_distance
%             min_distance_node_id = node_points(j).node_id;
%             min_distance = tmp_distance;
%         end
%     end
%     user_points(i).connected_node_id = min_distance_node_id;
%     node_points(min_distance_node_id).binding_users = ...
%         [node_points(min_distance_node_id).binding_users, user_points(i).user_id];
% end

for i = 1 : users_num
    distance_sequence = struct('distance', num2cell(ones(1, nodes_num) * Inf), ...
                               'node_id', num2cell(zeros(1, nodes_num)));
    for j = 2 : nodes_num
        distance_sequence(j).distance = compute_distance(user_points(i), node_points(j));
        distance_sequence(j).node_id = node_points(j).node_id;
    end
    
    [~, order] = sort([distance_sequence.distance]);
    connected_id = distance_sequence(order(randi(3))).node_id;
    user_points(i).distance = compute_distance(user_points(i), ...
                                               node_points(connected_id));  
    user_points(i).connected_node_id = connected_id;
    node_points(connected_id).binding_users = ...
        [node_points(connected_id).binding_users, user_points(i).user_id];

end




% --------------------------------------------------
function [distance] = compute_distance(point_a, point_b)

% 计算两点间的距离
distance = ((point_a.x - point_b.x)^2 + (point_b.x - point_b.y)^2)^0.5;

