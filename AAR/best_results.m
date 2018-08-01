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

result_ = zeros(length(M),length(H));

for l=1:length(L)
  for m=1:length(M)
    for h=1:length(H)
      M(m)
      aux_mse = result_test{l}.memory{m}.h{h}.mse
      aux_mnsc = result_test{l}.memory{m}.h{h}.mnsc
      
      if aux_mse < mse
        Param.L = l;
        Param.H = h;
        Param.M = m;
        mse = aux_mse;
      endif
    end
  end
endfor

if AR
  save(['','result_paramAR.mat'],'Param');
endif

if ARX
  save(['','result_paramARX.mat'],'Param');
endif
