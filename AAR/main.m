load_data

L = 4;
m = 30;
h = 1;

main_train(L,m,h,x_tr);

y_tr_tst = y_tr(m+1:end);

[y_pred] = main_test(L,m,h);
y_tr_tst = y_tr(m:end);

hold on;
  plot(1:columns(y_tr_tst),y_tr_tst);
  plot(1:columns(y_pred'),y_pred',"r");
  legend('Actual Value','Estimated Value');
hold off;
