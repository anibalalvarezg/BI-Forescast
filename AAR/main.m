# MAIN #
load_data

#Numero filas
L = 4; 
[x_L, x_H] = hsvd(x,L);

m = 120;
h = 1;

y_tst = aar(x_L,m,h) + aar(x_H,m,h);

hold on;
  plot(1:columns(y_tr),y_tr);
  plot(1:columns(y_tst),y_tst,"r");
  legend('Actual Value','Estimated Value');
hold off;
