load_data

lags = [20 30 40 50];
horizonte = [20  40];

% Pre_proceso
L = 4;
m = 30;
h = 1;
Ls = [4 6 8 10];
Ms = [20 25 30 35];
Hs = [1:20];

for l = 1:length(Ls)
  [a_L, a_H] = main_train(Ls(l),m,h,x_tr);
endfor

[y_pred] = main_test(L,m,h,x_tst);

y_tr_tst = x_tst(h+m+1:end);
y_pred = y_pred';

hold on;
  plot(1:columns(y_tr_tst),y_tr_tst);
  plot(1:columns(y_pred),y_pred,"r");
  legend('Actual Value','Estimated Value');
hold off;
