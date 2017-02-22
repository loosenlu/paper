function [allocated_matrix, node_points] = ...
    allocate_storage_satisfy_qos(user_points, node_points, ...
                                 objs_num, qos, nodes_cost_matrix_without_route)
                             


process_info = ...
    init_param(user_points, node_points, objs_num, qos, ...
               nodes_cost_matrix_without_route);
    
 
[allocated_matrix, process_info] = get_located_matrix_user_first(process_info);

storage = process_info.cache_info.storage_info;
[~, nodes_num] = size(node_points);
for i = 1 : nodes_num
    node_points(i).storage_used = storage(i).storage_used;
    node_points(i).load_factor = storage(i).load_factor;
end
    




% ------------------------------------------------------------

function [process_info] = ...
    init_param(user_points, node_points, objs_num, qos, network_info)

[~, nodes_num] = size(node_points);
% 初始化缓存信息
for i = 1 : nodes_num
    storage(i).id = node_points(i).node_id;
    storage(i).storage_capacity = node_points(i).storage_capacity;
    storage(i).storage_used = node_points(i).storage_used;
    storage(i).load_factor = node_points(i).load_factor;
end

cache_info.storage_info = storage;

[~, users_num] = size(user_points);
% 初始化运营商信息；
operator.users_num = users_num;
operator.user_location = [user_points.connected_node_id];
operator.file_objs_num = objs_num;
operator.cache_limit = Inf;
operator.qos = qos;
% 用户会访问运营商下所有文件对象；
operator.visited_preference = ones(objs_num, users_num);

process_info.nodes_num = nodes_num;
process_info.cache_info = cache_info;

visited_cost_matrix = network_info(operator.user_location, :);
operator.visited_cost_matrix = visited_cost_matrix;
process_info.operator = operator;
    
    
