function [y_pred]= aar(x,m,h)
  N = columns(x);
  
  vector_r = zeros(N,m+1);

  for i=1:columns(x)
    for j = 1:m+1
      if i >= j
        vector_r(i,j) = x(i-j+1);
      else
        vector_r(i,j) = 0;
      endif
    endfor
  endfor
  
  Y = vector_r(:,1);
  X = vector_r(:,2:end);
  a = pinv(X)*Y;
  
  suma_pred = 0;
  for i=1:m
    suma_pred+= a(i)* X(N,i);
  endfor
  
  y_pred = suma_pred;
end