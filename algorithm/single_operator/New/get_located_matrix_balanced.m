function [allocated_matrix] = get_located_matrix_balanced(process_info)


allocated_matrix = ...
    zeros(process_info.operator.file_objs_num, process_info.nodes_num);


process_info.storage_done = 0;

for i = 1 : process_info.operator.file_objs_num
    
    users_index_need_obj = ...
        find(process_info.operator.visited_preference(i, :) == 1);
    users_visited_matrix_need_obj = ...
        process_info.operator.visited_cost_matrix(users_index_need_obj, :);
    
    obj_info.users_index = users_index_need_obj;
    obj_info.users_visited_matrix = users_visited_matrix_need_obj;
    
    feasible_sol_sets = solve_feasible_sets(process_info, obj_info);
    
    [process_info, allocated_vector] = ...
            allocate_node_to_store_obj(process_info, feasible_sol_sets);
    
    allocated_matrix(i, :) = allocated_vector;
    
    if process_info.storage_done == 1
        return ;
    end
end


% ------------------------------------------------------------

function [feasible_sol_sets] = ...
    solve_feasible_sets(process_info, obj_info)
    
qos = process_info.operator.qos;
[users_num, ~] = size(obj_info.users_visited_matrix);

feasible_sol_sets.covered_nodes = [];
feasible_sol_sets.sol_sets = {};
feasible_sol_sets.user_recorder = {};

for i = 1 : users_num
    statisfied_qos_nodes = find(obj_info.users_visited_matrix(i,:) <= qos);
    feasible_sol_sets = find_feasible_set(feasible_sol_sets, ...
                          statisfied_qos_nodes, ...
                          obj_info.users_index(i));
end



function [feasible_sol_sets] = ...
    find_feasible_set(feasible_sol_sets, satisfied_qos_nodes, user_id)

[~, sols_num] = size(feasible_sol_sets.sol_sets);
feasible_sol_sets.covered_nodes = ...
    union(feasible_sol_sets.covered_nodes, satisfied_qos_nodes);

% FOR first user
if sols_num == 0
    feasible_sol_sets.sol_sets{1} = satisfied_qos_nodes;
    feasible_sol_sets.user_recorder{1} = user_id;
    return
end

for i = 1 : sols_num
    if isempty(intersect(feasible_sol_sets.sol_sets{i}, satisfied_qos_nodes)) ~= 1
        feasible_sol_sets.sol_sets{i} = ...
            intersect(feasible_sol_sets.sol_sets{i}, satisfied_qos_nodes);
        feasible_sol_sets.user_recorder{i} = [feasible_sol_sets.user_recorder{i}, user_id];
        return;
    end
end

feasible_sol_sets.sol_sets = ...
        [feasible_sol_sets.sol_sets, intersect(satisfied_qos_nodes, feasible_sol_sets.covered_nodes)];
feasible_sol_sets.user_recorder = ...
        [feasible_sol_sets.user_recorder, user_id];



% --------------------------------------------------------

function [process_info, allocated_vector] = ...
            allocate_node_to_store_obj(process_info, feasible_sol_sets)


[~, solutions_num] = size(feasible_sol_sets.sol_sets);
allocated_vector = zeros(1, process_info.nodes_num);
allocated_recorder = [];

for i = 1 : solutions_num
    users_index = feasible_sol_sets.user_recorder{i};
    nodes_index = feasible_sol_sets.sol_sets{i};
    [process_info, allocated_node_index] = ...
                        get_allocated_node_index(process_info, ...
                                                 allocated_recorder, ...
                                                 users_index, ...
                                                 nodes_index);
    
    allocated_recorder(i) = allocated_node_index;
    allocated_vector(allocated_node_index) = 1;
    
    % 检查是否超出了当前operator的容量限制
    process_info.operator.cache_limit = process_info.operator.cache_limit - 1;
    if process_info.operator.cache_limit == 0
        process_info.storage_done = 1;
        return;
    end 
   
    if (~check_cache(process_info))
        % 缓存容量不够；
        process_info.storage_done = 1;
        return;
    end
end



function [process_info, allocated_node_index] = ...
    get_allocated_node_index(process_info, allocated_recorder, users_index, nodes_index)


need_to_process_nodes = process_info.cache_info.storage_info(nodes_index);

allocated_node_index = 0;
if min([need_to_process_nodes.load_factor]) == 1
    % 待处理的node中，负载最小的node的load_factor都为1;
    % 则在可行解中的node已经无法存储文件对象了;
    [process_info, allocated_node_index] = ...
            solve_without_enough_storage(process_info, allocated_recorder, users_index);
     return;
end

%在备选节点中找出负载最小的几个节点进行处理；
need_to_process_nodes = ...
    need_to_process_nodes([need_to_process_nodes.load_factor] ...
                            == min([need_to_process_nodes.load_factor]));


[~, users_num] = size(users_index);
[~, nodes_num] = size(need_to_process_nodes);
visited_cost_matrix = process_info.operator.visited_cost_matrix;
min_visited_time = Inf;

for i = 1 : nodes_num
    
    % 如果待处理的node的缓存空间满了
    % 需寻找新的node；
    if need_to_process_nodes(i).load_factor == 1
        continue;
    end
    
    temp_min_visited_time = 0;
    % 在候选集合中选取访问总代价最小的结点；
    for j = 1 : users_num
        temp_min_visited_time = ...
            visited_cost_matrix(users_index(j), need_to_process_nodes(i).id) + ...
            temp_min_visited_time;
    end
    
    if temp_min_visited_time < min_visited_time
        min_visited_time = temp_min_visited_time;
        allocated_node_index = need_to_process_nodes(i).id;
    end
end


% update the cache infomation
if  ~any(allocated_recorder == allocated_node_index)
    % update storage_used
    process_info.cache_info.storage_info(allocated_node_index).storage_used = ...
        1 + process_info.cache_info.storage_info(allocated_node_index).storage_used;
    % update load_factor
    process_info.cache_info.storage_info(allocated_node_index).load_factor = ...
        process_info.cache_info.storage_info(allocated_node_index).storage_used / ...
        process_info.cache_info.storage_info(allocated_node_index).storage_capacity;
end


% --------------------------------------------------------

function [process_info, allocated_node_index] = ...
            solve_without_enough_storage(process_info, allocated_recorder, users_index)
        
% 
% users_index:
allocated_node_index = 0;
need_to_process_nodes = process_info.cache_info.storage_info;

% visited_cost_matrix = process_info.operator.visited_cost_matrix(users_index, :);

% [~, users_num] = size(users_index);
% if users_num == 1
%     users_satisfication = visited_cost_matrix <= process_info.operator.qos;
% else
%     users_satisfication = sum(visited_cost_matrix <= process_info.operator.qos);
% end
% 
% 
% [~, sequence_order] = sort(users_satisfication, 'descend');
% [~, sequence_len] = size(sequence_order);

[~, sequence_order] = sort([need_to_process_nodes.load_factor]);
allocated_node_index = sequence_order(1);


% for i = 1 : sequence_len
%     if need_to_process_nodes(sequence_order(i)).load_factor ~= 1
%         allocated_node_index = sequence_order(i);
%         break;
%     end
% end


% update the cache infomation
if  ~any(allocated_recorder == allocated_node_index)
    % update storage_used
    process_info.cache_info.storage_info(allocated_node_index).storage_used = ...
        1 + process_info.cache_info.storage_info(allocated_node_index).storage_used;
    % update load_factor
    process_info.cache_info.storage_info(allocated_node_index).load_factor = ...
        process_info.cache_info.storage_info(allocated_node_index).storage_used / ...
        process_info.cache_info.storage_info(allocated_node_index).storage_capacity;
end

% --------------------------------------------------------

function [state] = check_cache(process_info)


% 返回当前是否拥有空闲空间存储文件对象
% YES(1) OR NO(0)

state = 1;
if min([process_info.cache_info.storage_info.load_factor]) == 1
    state = 0;
end




