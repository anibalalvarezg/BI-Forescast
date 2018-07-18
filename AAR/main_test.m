# MAIN #
load_data;
load(['','a_L_H.mat']);
load(['','config.mat']);
 
[y_L, y_H] = hsvd(y_tr,config.L);

y_pred = aar_tst(y_L,config.m,config.h,a_L) + aar_tst(y_H,config.m,config.h,a_H);
y_tr_tst = y_tr(config.m+1:end);



hold on;
  plot(1:columns(y_tr_tst),y_tr_tst);
  plot(1:columns(y_pred'),y_pred',"r");
  legend('Actual Value','Estimated Value');
hold off;
