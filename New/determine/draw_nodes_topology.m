

hold on
for i = 1 : nodes_num + 1
    if i == 1
        plot(node_points(i).x, node_points(i).y, 'bo');
        continue;
    end
    
    plot(node_points(i).x, node_points(i).y, 'ro');
end



for i = 1 :nodes_num + 1
    for j = 1 : nodes_num + 1
        
        if nodes_topology(i, j) ~= Inf
            
            if i == 1 || j == 1
                plot([node_points(i).x, node_points(j).x], [node_points(i).y, node_points(j).y], 'b-');
                continue;
            end
            
            plot([node_points(i).x, node_points(j).x], [node_points(i).y, node_points(j).y], 'r-');
        end
    end
    
end


hold off