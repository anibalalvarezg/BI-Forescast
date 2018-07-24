MLP = false;
MLPX = true;

if MLP
  load(['','result_testMLP.mat']);
  load(['','config_paramMLP.mat']);
endif

if MLPX
  load(['','result_testMLPX.mat']);
  load(['','config_paramMLPX.mat']);
endif

L = Config.L;
M = Config.M;
H = Config.H;

mse = 99999;

result_ = zeros(length(M),length(H));

for l=1:length(L)
  for m=1:length(M)
    for h=1:length(H)
      aux_mse = result_test{l}.memory{m}.h{h}.mse;
      if aux_mse < mse
        Param.L = l;
        Param.H = h;
        Param.M = m;
        mse = aux_mse;
      endif
    end
  end
endfor

if MLP
  save(['','result_paramMLP.mat'],'Param');
endif

if MLPX
  save(['','result_paramMLPX.mat'],'Param');
endif