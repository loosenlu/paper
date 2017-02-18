function [slices_info] = ...
        generate_slice_info(nodes_num, init_info)
    
[slices_num, ~] = size(init_info);


for i = 1:slices_num
    
    slices_info(i).users_num = init_info(i, 1);
    slices_info(i).limited_time = init_info(i, 2);
    slices_info(i).obj_num = init_info(i, 3);
    slices_info(i).users_location = randi(nodes_num, 1, init_info(i, 1));
end