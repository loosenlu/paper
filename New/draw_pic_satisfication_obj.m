
hold on

satisfication_along_route = along_route(2, :);
satisfication_nearst_node = nearst_node(2, :);
satisfication_satisfy_qos = satisfy_qos(2, :);

plot(1:objs_num, satisfication_along_route, '-r');
plot(1:objs_num, satisfication_nearst_node, '-g');
plot(1:objs_num, satisfication_satisfy_qos, '-b');

sequence = 1:5:objs_num;
plot(sequence, satisfication_along_route(sequence), 'ro');
plot(sequence, satisfication_nearst_node(sequence), 'g*');
plot(sequence, satisfication_satisfy_qos(sequence), 'bd');

legend('Algorithm(along route)', 'Algorithm(nearst)', 'Algorithm(qos)','Location','southwest');
xlabel('File objects number');
ylabel('Satisfication');
grid on

hold off