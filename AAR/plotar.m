load_data
load(['','result_test.mat']);

zv = result_test{1}.memory{4}.h{1}.zv';
L = result_test{1}.L;
m = result_test{1}.memory{4}.M;
h = result_test{1}.memory{4}.h{1}.H;

datatst = x_tst(m+1:end);
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