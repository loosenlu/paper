function [delay_matrix, user_location] = ...
        topology_initialization(cache_node_number, user_number)

% get the delay matrix 
delay_tmp = randi(5, cache_node_number, cache_node_number);
delay_matrix = tril(delay_tmp, -1) + triu(delay_tmp, 1);


user_location = randi(cache_node_number, 1, user_number);

