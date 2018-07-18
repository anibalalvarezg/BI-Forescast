function [vector_r]= vector_reg(x,m,h)
  #len = length(x)-m-h+1;

  #for i=1:len
  #  xReg(i,:) = x(i:i+m+h-1)';
  #endfor
  #X = xReg(:,1:m);
  #Y = xReg(:,end);
  #a = pinv(X) * Y;
#====#
  N = columns(x);
  
  vector_r = zeros(N-m,m+1);

  for i=1+m:columns(x)
    for j = 1:m+1
        vector_r(i,j) = x(i-j+1);
    endfor
  endfor
  
  vector_r = vector_r(m+1:end,:);

#====#
  #x_n = x(1,end-m+1:end);
  #suma_pred = 0;
  #for i=1:m
  #  suma_pred+= a(i)* x_n(1,i);
  #endfor
  
  #y_pred(h) = suma_pred;
end