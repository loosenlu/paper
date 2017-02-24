


slice1 = sum(slice1_allocated_matrix);
slice2 = sum(slice2_allocated_matrix);
slice3 = sum(slice3_allocated_matrix);
slice4 = sum(slice4_allocated_matrix);
slice5 = sum(slice5_allocated_matrix);
slice6 = sum(slice6_allocated_matrix);
slice7 = sum(slice7_allocated_matrix);
slice8 = sum(slice8_allocated_matrix);

a = [slice1; slice2; slice3; slice4; slice5; slice6; slice7; slice8];
a = a(1:end, 2:end);

bar(a', 'stack');
legend('slice 1', 'slice 2', 'slice 3','slice 4','slice 5', 'slice 6', 'slice 7', 'slice 8');
xlabel('Slice ID');
ylabel('Storage View');