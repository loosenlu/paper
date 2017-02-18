function [cache_info] = generate_cache_info(cache_node_num, limit_space)


for i = 1 : cache_node_num
    cache_info(i).ID = i;
    cache_info(i).assigned_space = 0;
    cache_info(i).sum_sapce = limit_space;
    cache_info(i).load_factor = 0;
end
