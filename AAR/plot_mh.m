
AR = false;
ARX = true;

if AR
  load(['','result_testAR.mat']);
  load(['','config_param.mat']);
endif

if ARX
  load(['','result_testARX.mat']);
  load(['','config_paramARX.mat']);
endif

L = Config.L;
M = Config.M;
H = Config.H;

mse = 99999;
mejoras = zeros(length(M),length(H));

for l=1:length(L)
  for m=1:length(M)
    for h=1:length(H)
      mejoras(m,h) = result_test{l}.memory{m}.h{h}.mnsc*100;
    endfor
  endfor
endfor

hold on;
  plot(1:length(H),mejoras(1,1:end),"b-o");
  plot(1:length(H),mejoras(2,1:end),"r-o");
  plot(1:length(H),mejoras(3,1:end),"g-o");
  plot(1:length(H),mejoras(4,1:end),"y-o");
  legend("m=26","m=28","m=30","m=32");
  xlabel ("Horizonte");
  ylabel ("mNSE(%)");
hold off;