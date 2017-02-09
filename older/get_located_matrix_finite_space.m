function [located_matrix] = ...
    get_located_matrix_finite_space(user_cost_matrix, obj_num, limited_time, cache_info)


[user_num, cache_node_num] = size(user_cost_matrix);

located_matrix = zeros(obj_num, cache_node_num);

info.cache_info = cache_info;

for i = 1 : obj_num

    info.cover_node_range = [];
    info.solution_sets = {};
    info.user_recorder = {};
    info.unsolvable = 0;
    
    for j = 1 : user_num  
        satisfied_node_set = find(user_cost_matrix(j,:) <= limited_time);
        info = find_feasible_location(info, satisfied_node_set, j);
    end
    
    [info, located_vector] = ...
        locate_the_obj(info, user_cost_matrix, cache_node_num);       
    
    if info.unsolvable == 0
        located_matrix(i, :) = located_vector;
    else
        % unsolvable
        [info, located_index] = process_unsolvble_situation(info, user_cost_matrix);
        located_matrix(i, located_index) = 1;
    end
end


% --------------------------------------------------------

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

unsolvable_flag = 0;
for i = 1 : num
    users = info.user_recorder{i};
    nodes = info.solution_sets{i};
    [located_index, info.cache_info] = ...
        get_located_index(info.cache_info, user_cost_matrix, users, nodes);
    
    if located_index ~= 0
        located_vector(located_index) = 1;
        unsolvable_flag = 1;
    end
end

if unsolvable_flag == 0
    info.unsolvable = 1;
end



% --------------------------------------------------------

function [located_index, cache_info] = ...
    get_located_index(cache_info, user_cost_matrix, users, nodes)


located_index = 0;
nodes_info = cache_info(nodes);
min_load_node_index = ...
    find([nodes_info.load_factor] == min([nodes_info.load_factor]));

% each appropriate node don't have enough cache sapce;
if min([nodes_info.load_factor]) == 1
    return
end

% maybe there are several nodes has same load factor;
candidate_cache_nodes = nodes_info(min_load_node_index);

[~, user_num] = size(users);
[~, node_num] = size(candidate_cache_nodes);

min_time = Inf;
located_index = 0;

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


% --------------------------------------------------------

function [info, located_index] = ...
    process_unsolvble_situation(info, user_cost_matrix)


cache_info = info.cache_info;

min_load_node_index = ...
    find([cache_info.load_factor] == min([cache_info.load_factor]));

candidate_cache_nodes = cache_info(min_load_node_index);


[user_num, ~] = size(user_cost_matrix);
[~, node_num] = size(candidate_cache_nodes);

min_time = Inf;
located_index = 0;

for i = 1 : node_num
    temp_min_time = 0;
    for j = 1 : user_num
        temp_min_time = ...
            user_cost_matrix(j, candidate_cache_nodes(i).ID) + temp_min_time;
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
info.unsolvable = 0;

