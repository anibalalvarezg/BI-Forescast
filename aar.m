function [y_pred]= aar(x,m,h)
  N = columns(x);
  
  vector_r = zeros(N,m+1);

  for i=1:columns(x)
    for j = 1:m+1
      if i >= j
        vector_r(i,j) = x(i-j+1)
      else
        vector_r(i,j) = 0;
      endif
    endfor
  endfor
  y_pred = vector_r;
end