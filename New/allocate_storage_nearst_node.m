function [allocated_matrix, node_points] = ...
    allocate_storage_nearst_node(nodes_cost_matrix, objs_num, ...
                                 user_points, node_points)

[~, users_num] = size(user_points);
[~, nodes_num] = size(node_points);

allocated_matrix = zeros(objs_num, nodes_num);

for i = 1 : objs_num
    for j = 1 : users_num
        connected_node_id = user_points(j).connected_node_id;
        route = nodes_cost_matrix(connected_node_id, 1).route;
        for location = route(end:-1:1)
            if allocated_matrix(i, location) == 1
                break;
            elseif node_points(location).load_factor ~= 1
                allocated_matrix(i, location) = 1;
                node_points(location).storage_used = ...
                    node_points(location).storage_used + 1;
                node_points(location).load_factor = ...
                    node_points(location).storage_used / ...
                            node_points(location).storage_capacity;
                break;
            else
                % ÑØ×ÅÂ·¾¶ÍùÉÏ£»
                continue;
            end
        end
    end
end