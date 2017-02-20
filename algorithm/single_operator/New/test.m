


max_user_num = 100;
max_file_objs_num = 100;
nodes_num = 10;

for i = 1 : nodes_num
    storage(i).id = i;
    storage(i).storage_capacity = 50;
    storage(i).storage_used = 0;
    storage(i).load_factor = 0;
end

cache_info.storage_info = storage;
process_info.nodes_num = nodes_num;
process_info.cache_info = cache_info;


% % 随着用户的变化
% user_first_info = zeros(2, max_user_num);
% balanced_info = zeros(2, max_user_num);
% least_time_info = zeros(2, max_user_num);
% for i = 1 : max_user_num
%     
% % 初始化运营商信息；
% % ------------------------------------------
% operator.users_num = i;
% operator.user_location = users_location(1:i);
% % file objs = 100
% operator.file_objs_num = max_file_objs_num;
% % cache_limit = 500 -> Inf
% operator.cache_limit = 500;
% % QoS = 5ms
% operator.qos = 5;
% % 用户会访问运营商下所有文件对象；
% operator.visited_preference = ones(max_file_objs_num, i);
% % ------------------------------------------
% 
% operator.visited_cost_matrix = delay_matrix(operator.user_location, :);
% process_info.operator = operator;
% 
% % FOR user first
% allocated_matrix = get_located_matrix_user_first(process_info);
% [user_first_info(1, i),  user_first_info(2, i)] = ... 
%             analysis_algorithm(allocated_matrix, operator);
% 
% % FOR user first
% allocated_matrix = get_located_matrix_balanced(process_info);
% [balanced_info(1, i),  balanced_info(2, i)] = ... 
%             analysis_algorithm(allocated_matrix, operator);
% 
% % FOR least time
% allocated_matrix = get_located_matrix_least_time(process_info);
% [least_time_info(1, i),  least_time_info(2, i)] = ... 
%             analysis_algorithm(allocated_matrix, operator);
%     
% end
% 
% user_average_visited_time_by_user = ...
%     [user_first_info(1,:); balanced_info(1,:); least_time_info(1,:)];
%     
% user_satisfication_by_user = ...
%     [user_first_info(2,:); balanced_info(2,:); least_time_info(2,:)];


% 随着文件对象的变化
user_first_info = zeros(2, max_user_num);
balanced_info = zeros(2, max_user_num);
least_time_info = zeros(2, max_user_num);
for i = 1 : max_file_objs_num
    
% 初始化运营商信息；
% ------------------------------------------
operator.users_num = max_user_num;
operator.user_location = users_location;
% file objs = 100
operator.file_objs_num = i;
% cache_limit = 500 -> Inf
operator.cache_limit = 500;
% Qos = 5ms
operator.qos = 5;
% 用户会访问运营商下所有文件对象；
operator.visited_preference = ones(i, 100);
% ------------------------------------------

operator.visited_cost_matrix = delay_matrix(operator.user_location, :);
process_info.operator = operator;

% FOR user first
allocated_matrix = get_located_matrix_user_first(process_info);
[user_first_info(1, i),  user_first_info(2, i)] = ... 
            analysis_algorithm(allocated_matrix, operator);

% FOR user first
allocated_matrix = get_located_matrix_balanced(process_info);
[balanced_info(1, i),  balanced_info(2, i)] = ... 
            analysis_algorithm(allocated_matrix, operator);

% FOR least time
allocated_matrix = get_located_matrix_least_time(process_info);
[least_time_info(1, i),  least_time_info(2, i)] = ... 
            analysis_algorithm(allocated_matrix, operator);
    
end

user_average_visited_time_by_obj = ...
    [user_first_info(1,:); balanced_info(1,:); least_time_info(1,:)];
    
user_satisfication_by_obj = ...
    [user_first_info(2,:); balanced_info(2,:); least_time_info(2,:)];

clear max_user_num  max_file_objs_num  nodes_num;
clear storage cache_info 
clear user_first_info balanced_info least_time_info
clear i

