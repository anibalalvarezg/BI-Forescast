% Parameter Setup
Load_data

L = [7];
M = [29];
H = [1];

Config.L = L;
Config.M = M;
Config.H = H;

save(['','config_paramMLP.mat'],'Config');

train = true;
test  = false;

if (train)
  for l=1:length(L)
    result_train{l}.L = L(l);
    [x_L,x_H]= hsvd(x_tr,L(l));
    for m=1:length(M)      
      result_train{l}.memory{m}.M = M(m);
      for h=1:length(H)  
        result_train{l}.memory{m}.h{h}.H = H(h);

        vector_r = vector_reg(x_L,M(m)+h-1);
        ye_L = vector_r(:,1)';
        xe_L = vector_r(:,H(h)+1:end)';

        vector_r = vector_reg(x_H,M(m)+h-1);
        ye_H = vector_r(:,1)';
        xe_H = vector_r(:,H(h)+1:end)';

        result_train{l}.memory{m}.h{h}.Bmlp_L = mlp(xe_L,ye_L)';
        result_train{l}.memory{m}.h{h}.Bmlp_H = mlp(xe_H,ye_H)';
      endfor
    endfor
  endfor  
  save(['','result_trainMLP.mat'],'result_train');
endif

if (test)
#Load(['','Bmlp.mat']);
  load(['','result_trainMLP.mat']);
  for l=1:length(L)
    [y_L, y_H] = hsvd(x_tst,L(l));
    result_test{l}.L = L(l);

    for m=1:length(M)  
      result_test{l}.memory{m}.M = M(m);
      for h=1:length(H)
        result_test{l}.memory{m}.h{h}.H = H(h);

        vector_r = vector_reg(y_L,M(m)+h-1);
        xv_L = vector_r(:,H(h)+1:end)';
        
        vector_r = vector_reg(y_H,M(m)+h-1);
        xv_H = vector_r(:,H(h)+1:end)';
        
        Bmlp_L = result_train{l}.memory{m}.h{h}.Bmlp_L;
        Bmlp_H = result_train{l}.memory{m}.h{h}.Bmlp_H; 
        
        zv =mlp_test(xv_L,Bmlp_L.W)+mlp_test(xv_H,Bmlp_H.W);
        
        result_test{l}.memory{m}.h{h}.zv = zv;
        
                
        mse = mse_function(zv,x_tst(m+1:end));
        result_test{l}.memory{m}.h{h}.mse = mse;
        
        mnsc = mnse_function(zv,x_tst(m+1:end));
        result_test{l}.memory{m}.h{h}.mnsc = mnsc;
        
      endfor
    endfor
  endfor
#y_pred = y_pred';
  save(['','result_testMLP.mat'],'result_test');
endif

hold on;
  plot(1:length(zv),zv,"r");
  plot(1:length(zv),x_tst(M(1)+H(1):end),"b");
  legend("Pronóstico","Real");
hold off;
   