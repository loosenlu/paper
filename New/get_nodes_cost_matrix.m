function [nodes_cost_matrix] = get_nodes_cost_matrix(node_points)

%
% nodes_points: 表示网络中的缓存节点+数据源节点

[~, nodes_num] = size(node_points);

nodes_distance_matrix = ...
    compute_nodes_ideal_distance_matrix(node_points);
connected_gragh = create_connected_graph(node_points);

nodes_distance_matrix(connected_gragh == 0) = Inf;

% nodes_cost_matrix = nodes_distance_matrix / 500;
% nodes_cost_matrix(logical(eye(size(nodes_cost_matrix)))) = 1;
for i = 1 : nodes_num
    for j = 1: nodes_num
        [cost, route] = dijkstra(nodes_distance_matrix, i, j);
        nodes_cost_matrix(i, j).cost = cost;
        nodes_cost_matrix(i, j).route = route;
    end
end


% ----------------------------------------------
function [nodes_distance_matrix] = ...
        compute_nodes_ideal_distance_matrix(node_points)

[~, nodes_num] = size(node_points);
nodes_distance_matrix = zeros(nodes_num, nodes_num);

for i = 1 : nodes_num
    for j = 1 : nodes_num
        
        nodes_distance_matrix(i, j) = ...
        	(4 + ...
             compute_distance(node_points(i), node_points(j)) / 1000);
    end
end

% 找出几个离数据源较近的节点与数据源相连; 
% 其余的均为inf,即不相连；
connected_to_data_node_num = fix(randi((nodes_num - 1) / 2)) + 1;

distance_to_data_node = nodes_distance_matrix(1, :);

[~, order] = sort(distance_to_data_node);
for i = connected_to_data_node_num : nodes_num
    nodes_distance_matrix(1, order(i)) = inf;
    nodes_distance_matrix(order(i), 1) = inf;
end



% --------------------------------------------------
function [distance] = compute_distance(point_a, point_b)

% 计算两点间的距离
distance = ((point_a.x - point_b.x)^2 + (point_a.y - point_b.y)^2)^0.5;



% --------------------------------------------------
function [connected_graph] = create_connected_graph(node_points)

% 

[~, nodes_num] = size(node_points);
connected_graph = randi(2, nodes_num, nodes_num) - 1;
connected_graph = tril(connected_graph, -1) + triu(connected_graph, 1);
connected_graph(logical(eye(size(connected_graph)))) = 1;

random_sequence = randperm(nodes_num);

for i = 1 : nodes_num - 1
    connected_graph(random_sequence(i), random_sequence(i + 1)) = 1;
    connected_graph(random_sequence(i + 1), random_sequence(i)) = 1;
end



%---------------------------------------------------
% Dijkstra Algorithm
% author : Dimas Aryo
% email : mr.dimasaryo@gmail.com
%
% usage
% [cost rute] = dijkstra(Graph, source, destination)
% 
% example
% G = [0 3 9 0 0 0 0;
%      0 0 0 7 1 0 0;
%      0 2 0 7 0 0 0;
%      0 0 0 0 0 2 8;
%      0 0 4 5 0 9 0;
%      0 0 0 0 0 0 4;
%      0 0 0 0 0 0 0;
%      ];
% [e L] = dijkstra(G,1,7)
%---------------------------------------------------
function [e, L] = dijkstra(A,s,d)

if s==d
    % 修改前  
    % e = 0;
    % L = [s];
    % 修改后  
    e = A(s,d);
    L = [s];
else

A = setupgraph(A,inf,1);

if d==1
    d=s;
end
A=exchangenode(A,1,s);

lengthA=size(A,1);
W=zeros(lengthA);
for i=2 : lengthA
    W(1,i)=i;
    W(2,i)=A(1,i);
end

for i=1 : lengthA
    D(i,1)=A(1,i);
    D(i,2)=i;
end

D2=D(2:length(D),:);
L=2;
while L<=(size(W,1)-1)
    L=L+1;
    D2=sortrows(D2,1);
    k=D2(1,2);
    W(L,1)=k;
    D2(1,:)=[];
    for i=1 : size(D2,1)
        if D(D2(i,2),1)>(D(k,1)+A(k,D2(i,2)))
            D(D2(i,2),1) = D(k,1)+A(k,D2(i,2));
            D2(i,1) = D(D2(i,2),1);
        end
    end
    
    for i=2 : length(A)
        W(L,i)=D(i,1);
    end
end
if d==s
    L=[1];
else
    L=[d];
end
e=W(size(W,1),d);
L = listdijkstra(L,W,s,d);
end







