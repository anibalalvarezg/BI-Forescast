load_data
MLP = true;
MLPX = false;

if MLP
  load(['','result_testMLP.mat']);
  load(['','result_paramMLP.mat']);
  load(['','config_paramMLP.mat']);
endif

if MLPX
  load(['','result_testMLPX.mat']);
  load(['','result_paramMLPX.mat']);
  load(['','config_paramMLPX.mat']);
endif

val_L = L(Param.L)
val_M = M(Param.M)
val_H = H(Param.H)

Param.L
Param.M
Param.H

zv = result_test{Param.L}.memory{Param.M}.h{Param.H}.zv';
L  = result_test{Param.L}.L;
m  = result_test{Param.L}.memory{Param.M}.M;
h  = result_test{Param.L}.memory{Param.M}.h{Param.H}.H;

rmse = sqrt(result_test{Param.L}.memory{Param.M}.h{Param.H}.mse)
mae  = result_test{Param.L}.memory{Param.M}.h{Param.H}.mae
r2   = result_test{Param.L}.memory{Param.M}.h{Param.H}.r2
mnsc = result_test{Param.L}.memory{Param.M}.h{Param.H}.mnsc

x_tst2 = x_tst(m+h:end);

hold on;
  plot(1:length(zv),zv,"r");
  plot(1:length(zv),x_tst2,"b");
  legend("Pronóstico","Real");
hold off;
