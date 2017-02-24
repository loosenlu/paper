function [redundancy, storage_usage] = ... 
            analysis_algorithm_storage(allocated_matrix, storage_limit, objs_num)

       
result = allocated_matrix(1:objs_num, :);
redundancy = sum(sum(result, 2)) / objs_num; 
storage_usage = sum(result) / storage_limit;