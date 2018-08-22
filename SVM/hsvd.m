function [x_L,x_H]= hsvd(x,L)
  N = columns(x);
  
  #Columnas
  M=N-L+1;
  
  #Matriz hankel
  H = zeros(L,M);
  for i=1:L
    for j=1:M
      H(i,j) = x(i+j-1);
    end
  end
  [U,S,V] = svd(H);
  S = diag(S);

  C = zeros(L,N);
  for i=1:L
    A =(S(i) * U(1:end,i)) * V(1:end,i)';
    C(i,1:end) = [A(1,1:M) A(2:L,M)'];
  endfor
  
  x_L = C(1,1:end);
  x_H = C(2:L,1:end);
  x_H = sum(x_H);
end