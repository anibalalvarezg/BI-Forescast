# MAIN #
load_data
x = x_tr';

#Numero filas
L = 4; 
[x_L, x_H] = hankel(x,L);

m = 120;
y_tr = y_tr';
h = 1;

y_tst = aar(x_L,m,h) + aar(x_H,m,h);
columns(y_tst);
hold on;
  plot(1:columns(y_tr),y_tr);
  plot(1:columns(y_tst),y_tst,"r");
  legend('Actual Value','Estimated Value');
hold off;
