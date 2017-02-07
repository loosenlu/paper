function [located_matrix] = ...
    get_located_matrix_no_balanced(user_cost_matrix, obj_num, limited_time, cache_info)

% 
% Get the file object located matrix.
% user_cost_matrix: User visit time;
% obj_num: file object number;
% limited_time: QoS limited;
% cache_info: cache information;

[user_num, cache_node_num] = size(user_cost_matrix);

located_matrix = zeros(obj_num, cache_node_num);

info.cover_node_range = [];
info.solution_sets = {};
info.user_recorder = {};

info.limited_time = limited_time;
info.cache_info = cache_info;

for i = 1 : user_num  
    satisfied_node_set = find(user_cost_matrix(i,:) <= info.limited_time);
    info = find_feasible_location(info, satisfied_node_set, i);
end


for i = 1 : obj_num
    
    [info, located_vector] = ...
        locate_the_obj(info, user_cost_matrix, cache_node_num);       
    
    located_matrix(i, :) = located_vector;
end



% ------------------------------------------------------------

function [info] = ...
    find_feasible_location(info, satisfied_node_set, user_ID)

[~, num] = size(info.solution_sets);
info.cover_node_range = union(info.cover_node_range, satisfied_node_set);

% FOR first user
if num == 0
    info.solution_sets{1} = satisfied_node_set;
    info.user_recorder{1} = user_ID;
    return
end

for i = 1 : num
    if isempty(intersect(info.solution_sets{i}, satisfied_node_set)) ~= 1
        info.solution_sets{i} = ...
            intersect(info.solution_sets{i}, satisfied_node_set);
        info.user_recorder{i} = [info.user_recorder{i}, user_ID];
        return;
    end
end

info.solution_sets = ...
        [info.solution_sets, intersect(satisfied_node_set, info.cover_node_range)];
info.user_recorder = ...
        [info.user_recorder, user_ID];



% --------------------------------------------------------

function [info, located_vector] = ...
    locate_the_obj(info, user_cost_matrix, cache_nodes_num)


[~, num] = size(info.solution_sets);
located_vector = zeros(1, cache_nodes_num);

for i = 1 : num
    users = info.user_recorder{i};
    nodes = info.solution_sets{i};
    [located_index, info] = ...
        get_located_index(info, user_cost_matrix, users, nodes);
    
    if located_index ~= 0
        located_vector(located_index) = 1;
    end
end




% --------------------------------------------------------

function [located_index, info] = ...
    get_located_index(info, user_cost_matrix, users, nodes)


cache_info = info.cache_info;
nodes_info = cache_info(nodes);
located_index = 0;

if min([nodes_info.load_factor]) == 1
    % FOR now don't have enough space.
    [located_index, info] = ...
        process_without_enough_scpace(info, user_cost_matrix, users);
    return;
end

% Find the node can store file objects
candidates_index = ...
    find([nodes_info.load_factor] ~= 1);
candidate_cache_nodes = nodes_info(candidates_index);

[~, user_num] = size(users);
[~, node_num] = size(candidate_cache_nodes);

min_time = Inf;

for i = 1 : node_num
    temp_min_time = 0;
    for j = 1 : user_num
        temp_min_time = ...
            user_cost_matrix(users(j), candidate_cache_nodes(i).ID) + temp_min_time;
    end
    if temp_min_time < min_time
        min_time = temp_min_time;
        located_index = candidate_cache_nodes(i).ID;
    end
end

% update the cache infomation
cache_info(located_index).assigned_space = 1 + cache_info(located_index).assigned_space;
cache_info(located_index).load_factor = ...
    cache_info(located_index).assigned_space / cache_info(located_index).sum_sapce;
info.cache_info = cache_info;



% --------------------------------------------------------

function [located_index, info] = ...
    process_without_enough_scpace(info, user_cost_matrix, users)


cache_info = info.cache_info;
located_index = 0;

processed_user_cost_matrix = user_cost_matrix(users, :);
customer_satisfaction_vector = sum(processed_user_cost_matrix <= info.limited_time);
[~, processing_sequence] = sort(customer_satisfaction_vector, 'descend');

[~, sequence_length] = size(processing_sequence);
for i = 1 : sequence_length
    
    if cache_info(processing_sequence(i)).load_factor ~= 1
        located_index = processing_sequence(i);
        break;
    end
end


% update the cache infomation
cache_info(located_index).assigned_space = 1 + cache_info(located_index).assigned_space;
cache_info(located_index).load_factor = ...
    cache_info(located_index).assigned_space / cache_info(located_index).sum_sapce;

info.cache_info = cache_info;

