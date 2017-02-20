function [average_visited_time, users_satisfication] = ... 
            analysis_algorithm(allocated_matrix, operator)

users_num = operator.users_num;
objs_num = operator.file_objs_num;

visited_cost_matrix = operator.visited_cost_matrix;
users_really_visited_time = zeros(users_num, objs_num);

for i = 1 : users_num
    
    ith_visited_cost_vector = visited_cost_matrix(i,:);
    for j = 1 : objs_num
        
        if any(allocated_matrix(j, :) == 1)
            users_really_visited_time(i, j) = ...
                min(ith_visited_cost_vector(allocated_matrix(j, :) ~= 0));
        else
            % 访问远端服务器
            users_really_visited_time(i, j) = 30;
        end
    end
end


average_visited_time = sum(sum(users_really_visited_time)) / (users_num * objs_num);
users_satisfication_percent = ...
    sum(users_really_visited_time <= operator.qos, 2) / objs_num;
% 满意率高于70%的用户数
users_satisfication = sum(users_satisfication_percent >= 0.7) / users_num;


