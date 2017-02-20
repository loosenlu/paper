function [network_info, operator_info, cache_info] = ...
    init_info(nodes_num, max_time, operator_num, max_users, max_file_objs, capacity)


%
% nodes_num: 缓存节点个数；
% max_time: 节点间最大的访问时间；
% operator_num: 运营商个数；
% max_users: 每个运营商最多包含多少个用户
% max_file_objs: 每个运营商最多包含多少个文件对象；
% capacity: 每个缓存节点的容量是多少；


network_info = generate_network_info(nodes_num, max_time);
operator_info = generate_operator_info(nodes_num, operator_num, max_users, max_file_objs);
cache_info = generate_cache_info(nodes_num, capacity);



% ------------------------------------------

function [network_info] = generate_network_info(nodes_num, max_time)

%
% nodes_num:
% max_time: 

tmp = randi(max_time, nodes_num, nodes_num);
network_info = tril(tmp, -1) + triu(tmp, 1);


% ------------------------------------------

function [cache_info] = generate_cache_info(nodes_num, capacity)

% 
% nodes_num: 
% cache_limit:

for i = 1 : nodes_num
    storage(i).id = i;
    storage(i).storage_capacity = capacity;
    storage(i).storage_used = 0;
    storage(i).load_factor = 0;
end

cache_info.storage_info = storage;


% ------------------------------------------

function [operator_info] = generate_operator_info( ...
                            nodes_num, operator_num, ...
                            users_num, file_objs_num)

% 产生运营商信息
% nodes_num: 网络中缓存节点个数；
% operator_num: 网络中运营商个数；
% users_num: 运营商下最大用户数；
% file_objs_num: 运营商包含的文件对象个数；

for i = 1 : operator_num
    operator_info(i) = ...
        generate_single_operator_info(nodes_num, ...
                                      users_num, ...
                                      file_objs_num, ...
                                      100, ...
                                      5);
end


% ----------------------------------

function [operator] = generate_single_operator_info(...
                            nodes_num, users_num, file_objs_num, ...
                            cache_limit, qos)

operator.users_num = users_num;
operator.user_location = randi(nodes_num, 1, users_num);

operator.file_objs_num = file_objs_num;
operator.cache_limit = cache_limit;
operator.qos = qos;
% 用户会访问运营商下所有文件对象；
operator.visited_preference = ones(file_objs_num, users_num);
