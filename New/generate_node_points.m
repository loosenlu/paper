function [node_points] = ...
    generate_node_points(nodes_num, storage_limited, x_range, y_range)

% 生成网络缓存节点位置
% x_range: 表示x坐标的最大范围；
% y_range: 表示y坐标的最大范围；

% 在模型中需要随机添加一个数据源节点；
% 因此nodes_num + 1;

node_points = struct('node_id', num2cell(0:nodes_num), ...
                     'x', num2cell(rand(1,nodes_num + 1) * x_range), ...
                     'y', num2cell(rand(1,nodes_num + 1) * y_range), ...
                     'storage_capacity', num2cell(ones(1, nodes_num + 1) * storage_limited), ...
                     'storage_used', num2cell(zeros(1, nodes_num + 1)), ...
                     'load_factor', num2cell(zeros(1, nodes_num + 1)), ...
                     'binding_users', cell(1, nodes_num + 1));

% 数据源节点的index为1；
% 数据源节点应该位于其他节点范围之外；
node_points(1).x = x_range + rand * x_range / 5;
node_points(1).y = x_range + rand * y_range / 5;
node_points(1).storage_capacity = 0;

                    