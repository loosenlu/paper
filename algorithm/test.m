
[delay_matrix, user_location] = topology_initialization(5, 5);
[user_cost_matrix] = get_user_cost_matrix(delay_matrix, user_location);
        
[located_matrix] = get_located_matrix(user_cost_matrix, 20, 4);