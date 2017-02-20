function [node_points] = generate_node_points(nodes_num, x_range, y_range)

% �������绺��ڵ�λ��
% x_range: ��ʾx��������Χ��
% y_range: ��ʾy��������Χ��

% ��ģ������Ҫ������һ������Դ�ڵ㣻
% ���nodes_num + 1;

node_points = struct('id', num2cell(0:nodes_num), ...
                     'x', num2cell(rand(1,nodes_num + 1) * x_range), ...
                     'y', num2cell(rand(1,nodes_num + 1) * y_range));

% ����Դ�ڵ��indexΪ1��
% ����Դ�ڵ�Ӧ��λ�������ڵ㷶Χ֮�⣻
node_points(1) = struct('id',0, ...
                        'x',x_range + rand * x_range / 5, ...
                        'y',x_range + rand * y_range / 5);