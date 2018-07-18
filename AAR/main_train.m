function [a_L,a_H]= main_train(L,m,h,x_tr)
  #Numero filas
 
  [x_L, x_H] = hsvd(x_tr,L);

  a_L = aar_tr(x_L,m,h);
  a_H = aar_tr(x_H,m,h);

  
  save(['','a_L_H.mat'],'a_L','a_H');
endfunction