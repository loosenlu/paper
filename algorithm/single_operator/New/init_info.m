function [network_info, operator_info, cache_info] = ...
    init_info(nodes_num, max_time, operator_num, max_users, max_file_objs, capacity)


%
% nodes_num: ����ڵ������
% max_time: �ڵ�����ķ���ʱ�䣻
% operator_num: ��Ӫ�̸�����
% max_users: ÿ����Ӫ�����������ٸ��û�
% max_file_objs: ÿ����Ӫ�����������ٸ��ļ�����
% capacity: ÿ������ڵ�������Ƕ��٣�


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

% ������Ӫ����Ϣ
% nodes_num: �����л���ڵ������
% operator_num: ��������Ӫ�̸�����
% users_num: ��Ӫ��������û�����
% file_objs_num: ��Ӫ�̰������ļ����������

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
% �û��������Ӫ���������ļ�����
operator.visited_preference = ones(file_objs_num, users_num);
