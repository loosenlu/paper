hold on

bar([storage_usage_route(2:end); storage_usage_nearst(2:end); storage_usage_satisfication(2:end)]');

legend('Algorithm(along route)', 'Algorithm(nearst)', 'Algorithm(qos)','Location','southwest');
xlabel('Cache node Id');
ylabel('Storage usage');
grid on

hold off