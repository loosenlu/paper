function [delay_matrix, users_location] = ...
        topology_initialization(nodes_num, users_num, max_time)

% get the delay matrix 
delay_tmp = randi(max_time, nodes_num, nodes_num);
delay_matrix = tril(delay_tmp, -1) + triu(delay_tmp, 1);

users_location = randi(nodes_num, 1, users_num);
