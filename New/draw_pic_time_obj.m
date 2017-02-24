
hold on

time_along_route = along_route(1, :);
time_nearst_node = nearst_node(1, :);
time_satisfy_qos = satisfy_qos(1, :);

plot(1:objs_num, time_along_route, '-r');
plot(1:objs_num, time_nearst_node, '-g');
plot(1:objs_num, time_satisfy_qos, '-b');

sequence = 1:5:objs_num;
plot(sequence, time_along_route(sequence), 'ro');
plot(sequence, time_nearst_node(sequence), 'g*');
plot(sequence, time_satisfy_qos(sequence), 'bd');

legend('Algorithm(along route)', 'Algorithm(nearst)', 'Algorithm(qos)','Location','northwest');
xlabel('File objects number');
ylabel('Visited time(ms)');
grid on

hold off