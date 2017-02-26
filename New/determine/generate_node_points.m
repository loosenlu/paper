function [node_points] = ...
    generate_node_points(nodes_num, storage_limited, x_range, y_range)

% �������绺��ڵ�λ��
% x_range: ��ʾx��������Χ��
% y_range: ��ʾy��������Χ��

% ��ģ������Ҫ������һ������Դ�ڵ㣻
% ���nodes_num + 1;

node_points = struct('node_id', num2cell(1:nodes_num + 1), ...
                     'x', num2cell(randi(x_range, 1, nodes_num + 1)), ...
                     'y', num2cell(randi(y_range, 1, nodes_num + 1)), ...
                     'storage_capacity', num2cell(ones(1, nodes_num + 1) * storage_limited), ...
                     'storage_used', num2cell(zeros(1, nodes_num + 1)), ...
                     'load_factor', num2cell(zeros(1, nodes_num + 1)), ...
                     'binding_users', cell(1, nodes_num + 1));

% ����Դ�ڵ��indexΪ1��
% ����Դ�ڵ�Ӧ��λ�������ڵ㷶Χ֮�⣻
node_points(1).x = x_range + rand;
node_points(1).y = x_range + rand;
node_points(1).storage_capacity = Inf;
                    