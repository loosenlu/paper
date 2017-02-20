function [user_points] = generate_user_points(users_num, x_range, y_range)

% �����û��ڵ�λ��
% x_range: ��ʾx��������Χ��
% y_range: ��ʾy��������Χ��

user_points = struct('conneted_id', num2cell(zeros(1, users_num)), ...
                     'x', num2cell(rand(1,users_num) * x_range), ...
                     'y', num2cell(rand(1,users_num) * y_range));