load_data
AR = true;
ARX = false;
if AR
  load(['','result_testAR.mat']);
  load(['','result_paramAR.mat']);
endif

if ARX
  load(['','result_testARX.mat']);
  load(['','result_paramARX.mat']);
endif

zv = result_test{Param.L}.memory{Param.M}.h{Param.H}.zv';
L = result_test{Param.L}.L;
m = result_test{Param.L}.memory{Param.M}.M;
h = result_test{Param.L}.memory{Param.M}.h{Param.H}.H;

%datatst = x_tst(m+1:end);
datatst = x_tst;
pronostico = zv;
p = polyfit(pronostico,datatst((length(datatst) - length(pronostico))+1:end),1) %% saco los valores y = 32173612873912x + b (los de antes de x y el b)
f = polyval(p,pronostico);

figure(2)
hold on;
plot(pronostico , datatst((length(datatst) - length(pronostico))+1:end),'o');
plot(pronostico,f,'-r');
plot(datatst((length(datatst) - length(pronostico))+1:end),datatst((length(datatst) - length(pronostico))+1:end),':b');
hold off; 
xlabel('X');
ylabel('Y');
title("AR");
legend("data point", "best linear fit", "Y=X")
set(gca,'XTick',[0:5:100]);
set(gca,'YTick',[0:5:100]);
grid on