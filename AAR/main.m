load_data

lags = [2 4 6 8];
horizonte = [20 30];

train = true;
test = false;
ejemplo = false;
% Pre_proceso
%L = 4;
m = 30;
%h = 1;
Ls = [4 6 8 10];
%Ms = [20 25 30 35];
Hs = [1:20];


if(train)
  for l = 1:length(Ls)
    results{l}.lag = lags(l);
    results{l}.error = [];
    % Se predice desde h=1 hasta h=dtst
    results{l}.zv = [];
    results{l}.ar = cell(horizonte);
    for h=horizonte(1):horizonte(2)
      [a_L, a_H] = main_train(Ls(l),m,h,x_tr);
      results{l}.a_L{h} = a_L;
      results{l}.a_H{h} = a_H;
    endfor
  endfor
  save(['','result.mat'],'results');
end

if(test)
  load(['','result.mat']);
  for lag=1:length(lags)
    for h=horizonte(1):horizonte(2)
    
    endfor
  endfor

 [y_pred] = main_test(L,m,h,x_tst);
  y_tr_tst = x_tst(h+m+1:end);
  y_pred = y_pred';
end

#hold on;
#  plot(1:columns(y_tr_tst),y_tr_tst);
#  plot(1:columns(y_pred),y_pred,"r");
#  legend('Actual Value','Estimated Value');
#hold off;
