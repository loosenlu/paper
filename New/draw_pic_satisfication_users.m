hold on

satisfication_along_route = along_route_user(2, :);
satisfication_nearst_node = nearst_node_user(2, :);
satisfication_satisfy_qos = satisfy_qos_user(2, :);

plot(1:users_num, satisfication_along_route, '-r');
plot(1:users_num, satisfication_nearst_node, '-g');
plot(1:users_num, satisfication_satisfy_qos, '-b');

sequence = 5:5:users_num;
plot(sequence, satisfication_along_route(sequence), 'ro');
plot(sequence, satisfication_nearst_node(sequence), 'g*');
plot(sequence, satisfication_satisfy_qos(sequence), 'bd');

legend('Algorithm(along route)', 'Algorithm(nearst)', 'Algorithm(qos)','Location','southwest');
xlabel('User number');
ylabel('Satisfication');
grid on

hold off