function [user_points] = generate_user_points(users_num, x_range, y_range)

% 生成用户节点位置
% x_range: 表示x坐标的最大范围；
% y_range: 表示y坐标的最大范围；

user_points = struct('conneted_id', num2cell(zeros(1, users_num)), ...
                     'x', num2cell(rand(1,users_num) * x_range), ...
                     'y', num2cell(rand(1,users_num) * y_range));