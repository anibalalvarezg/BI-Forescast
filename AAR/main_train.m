# MAIN #
load_data

#Numero filas
config.L = 4; 
[x_L, x_H] = hsvd(x_tr,config.L);

config.m = 30;
config.h = 1;

a_L = aar_tr(x_L,config.m,config.h);
a_H = aar_tr(x_H,config.m,config.h);

save(['','a_L_H.mat'],'a_L','a_H');
save(['','config.mat'],'config');


#y_pred = zeros(1,147);


#x_n = x(1,end-m+1:end);
#for j = 1:147
#  suma_pred = 0;
#  for i=1:m
#    suma_pred+= a(i)* x_n(1,i);
#  endfor
#  y_pred(j) = suma_pred;
#  x_n = x_n(x_n~=x_n(1));
#  x_n = [x_n y_pred(j)];
#endfor

#hold on;
#  plot(1:columns(y_tr),y_tr);
#  plot(1:columns(y_tst),y_tst,"r");
#  legend('Actual Value','Estimated Value');
#hold off;
