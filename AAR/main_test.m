function [y_pred] = main_test(L,m,h)
  load(['','a_L_H.mat']);   
  [y_L, y_H] = hsvd(y_tr,L);
  y_pred = aar_tst(y_L,m,h,a_L) + aar_tst(y_H,m,h,a_H);
endfunction

