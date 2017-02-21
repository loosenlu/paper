function [user_points, node_points] = ...
    connect_users_to_nodes(user_points, node_points)

% ��ȡ��ǰ�û����������, ���û����ӵ���һ���ڵ��ϣ�
% user�����ӵ���������Ļ���ڵ�(����������Դ�ڵ�)��

% user_points: ��ʾ�û���λ�ã�
% node_points: ��ʾ����ڵ��λ�ã�

[~, nodes_num] = size(node_points);
[~, users_num] = size(user_points);

for i = 1 : users_num
    min_distance_node_id = 0;
    min_distance = Inf;
    for j = 2 : nodes_num
        tmp_distance = compute_distance(user_points(i), node_points(j));
        if tmp_distance < min_distance
            min_distance_node_id = node_points(j).node_id;
            min_distance = tmp_distance;
        end
    end
    user_points(i).connected_node_id = min_distance_node_id;
    node_points(min_distance_node_id).binding_users = ...
        [node_points(min_distance_node_id).binding_users, user_points(i).user_id];
end



% --------------------------------------------------
function [distance] = compute_distance(point_a, point_b)

% ���������ľ���
distance = ((point_a.x - point_b.x)^2 + (point_b.x - point_b.y)^2)^0.5;

