function [located_matrix] = ...
    get_located_matrix_infinite_space(user_cost_matrix, obj_num, limited_time)


[user_num, cache_node_num] = size(user_cost_matrix);

located_matrix = zeros(obj_num, cache_node_num);

for i = 1 : obj_num

    info.cover_node_range = [];
    info.solution_sets = {};
    info.user_recorder = {};
    
    for j = 1 : user_num  
        satisfied_node_set = find(user_cost_matrix(j,:) <= limited_time);
        info = find_feasible_location(info, satisfied_node_set, j);
    end
    
    located_matrix(i, :) = ...
        locate_the_obj(info, user_cost_matrix, cache_node_num);
    
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

function [located_vector] = ...
    locate_the_obj(info, user_cost_matrix, cache_nodes_num)


[~, num] = size(info.solution_sets);
located_vector = zeros(1, cache_nodes_num);

for i = 1 : num
    users = info.user_recorder{i};
    nodes = info.solution_sets{i};
    located_vector(get_located_index(user_cost_matrix, users, nodes)) = 1;
end



% --------------------------------------------------------

function [located_index] = ...
    get_located_index(user_cost_matrix, users, nodes)

[~, user_num] = size(users);
[~, node_num] = size(nodes);
min_time = Inf;
located_index = 0;

for i = 1 : node_num
    temp_min_time = 0;
    for j = 1 : user_num
        temp_min_time = user_cost_matrix(users(j), nodes(i)) + temp_min_time;
    end
    if temp_min_time < min_time
        min_time = temp_min_time;
        located_index = nodes(i);
    end
end