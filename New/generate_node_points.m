function [node_points] = generate_node_points(nodes_num, x_range, y_range)

% 生成网络缓存节点位置
% x_range: 表示x坐标的最大范围；
% y_range: 表示y坐标的最大范围；

% 在模型中需要随机添加一个数据源节点；
% 因此nodes_num + 1;

node_points = struct('id', num2cell(0:nodes_num), ...
                     'x', num2cell(rand(1,nodes_num + 1) * x_range), ...
                     'y', num2cell(rand(1,nodes_num + 1) * y_range));

% 数据源节点的index为1；
% 数据源节点应该位于其他节点范围之外；
node_points(1) = struct('id',0, ...
                        'x',x_range + rand * x_range / 5, ...
                        'y',x_range + rand * y_range / 5);