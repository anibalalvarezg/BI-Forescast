load_data
load(['','result_test.mat']);

zv = result_test{1}.memory{4}.h{1}.zv';
L = result_test{1}.L;
m = result_test{1}.memory{4}.M;
h = result_test{1}.memory{4}.h{1}.H;
hold on;
  plot(1:length(zv),zv,"r");
  plot(1:length(zv),x_tst(m+1:end),"b");
  legend("Pronóstico","Real");
hold of;
