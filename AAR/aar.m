function [y_pred]= aar(x,m,h)
  vector_r = vector_reg(x,m,h);
  Y = vector_r(:,1);
  X = vector_r(:,2:end);
  X = fliplr(X);
  a = pinv(X)*Y;
  
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