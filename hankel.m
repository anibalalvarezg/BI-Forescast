function [H]= hankel(x,L)
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
end