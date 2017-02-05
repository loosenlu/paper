function [min_time, allocation_matrix]= ...
    compute_min_time(user_cost_matrix, obj_num, limited_time)
% compute the max throughput
% user_cost_matrix: User visit cache node's time
% obj_num: obj number

[user_num, cache_node_num] = size(user_cost_matrix);
balance_factor = fix(obj_num / cache_node_num);

don = binvar(obj_num, cache_node_num, 'full');


Constraints = [];

% each obj can stored on one cache node;
for i = 1 : obj_num
    Constraints = [Constraints, sum(don(i,:)) >= 1];
end

for i = 1 : cache_node_num
    Constraints = [Constraints, sum(don(:, i)) <= balance_factor];
end


obj_function = 0;
for i = 1 : user_num
    for j = 1 : obj_num
        visited_jth_obj = user_cost_matrix(i, :) .*  don(j, :);
        % Constraints = [Constraints, sum(visited_jth_obj) <= limited_time];
        obj_function = obj_function + sum(visited_jth_obj);
    end
end


% for i = 1 : user_num
%     for j = 1 : obj_num
%         visited_jth_obj = user_cost_matrix(i, :) .*  don(j, :);
%         min_cost = min(visited_jth_obj(visited_jth_obj~=0));
%         Constraints = [Constraints, min_cost <= limited_time];
%         obj_function = obj_function + min_cost;
%     end
% end


optimize(Constraints, obj_function);
min_time = value(obj_function);
allocation_matrix = value(don);
