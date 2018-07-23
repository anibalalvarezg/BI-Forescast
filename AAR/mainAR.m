load_data
L = [2];
M = [32];
H = [10];

Config.L = L;
Config.M = M;
Config.H = H;

save(['','config_param.mat'],'Config');

train = true;
test  = true;

%train
if(train)
  for l=1:length(L)
    result_train{l}.L = L(l);
    [x_L, x_H] = hsvd(x_tr,L(l));
    for m=1:length(M)  
      result_train{l}.memory{m}.M = M(m);

      for h=1:length(H)
        result_train{l}.memory{m}.h{h}.H = H(h);

        vector_r = vector_reg(x_L,M(m)+H(h)-1);
        ye_L = vector_r(:,1);
        xe_L = vector_r(:,H(h)+1:end);

        vector_r = vector_reg(x_H,M(m)+H(h)-1);
        ye_H = vector_r(:,1);
        xe_H = vector_r(:,H(h)+1:end);
     
        a_L = pinv(xe_L) * ye_L;
        a_H = pinv(xe_H) * ye_H;
        
        result_train{l}.memory{m}.h{h}.a_L = a_L;
        result_train{l}.memory{m}.h{h}.a_H= a_H;
      endfor
    endfor
  endfor
  save(['','result_trainAR.mat'],'result_train');
endif

%test
if(test)
  load(['','result_trainAR.mat']);

  for l=1:length(L)
    result_test{l}.L = L(l);
    [y_L, y_H] = hsvd(x_tst,L(l));
    for m=1:length(M)
      result_test{l}.memory{m}.M = M(m);

      for h=1:length(H)
        result_test{l}.memory{m}.h{h}.H = H(h);
        
        vector_r = vector_reg(y_L,M(m)+H(h)-1);
        xv_L = vector_r(:,H(h)+1:end);
        a_L = result_train{l}.memory{m}.h{h}.a_L;
        y_pred_L = xv_L * a_L;

        vector_r = vector_reg(y_H,M(m)+H(h)-1);
        xv_H = vector_r(:,H(h)+1:end);
        a_H = result_train{l}.memory{m}.h{h}.a_H;
        y_pred_H = xv_H * a_H;

        zv = y_pred_L + y_pred_H;
        result_test{l}.memory{m}.h{h}.zv = zv;
        
        x_tst2 = x_tst(M(m)+H(h):end);

        mse = mse_function(zv,x_tst2);
        result_test{l}.memory{m}.h{h}.mse = mse;
        
        r2 = r_function(zv,x_tst2);
        result_test{l}.memory{m}.h{h}.r2 = r2;

        mae = mae_function(zv,x_tst2);
        result_test{l}.memory{m}.h{h}.mae = mae;

        mnsc = mnse_function(zv,x_tst2);
        result_test{l}.memory{m}.h{h}.mnsc = mnsc;
      endfor
    endfor
  endfor
  save(['','result_testAR.mat'],'result_test');
endif
