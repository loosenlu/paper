function [node_points] = generate_user_points(users_num, x_range, y_range)

% �����û��ڵ�λ��
% x_range: ��ʾx��������Χ��
% y_range: ��ʾy��������Χ��

node_points = struct('x', num2cell(rand(1,users_num) * x_range), ...
                     'y', num2cell(rand(1,users_num) * y_range));