function [y_pred]= aar(x,m,h)
  a = arr_tr(x,m,h);
  
  y_pred = zeros(1,147);
  
  x_n = x(1,end-m+1:end);
  for j = 1:147
    suma_pred = 0;
    for i=1:m
      suma_pred+= a(i)* x_n(1,i);
    endfor
    y_pred(j) = suma_pred;
    x_n = x_n(x_n~=x_n(1));
    x_n = [x_n y_pred(j)];
  endfor
end