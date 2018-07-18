function [a]= aar_tr(x,m,h)
  vector_r = vector_reg(x,m,h);
  H = MatrizHankel(m+h-1,x');
  xe = H(:, 1:(size(H)(2)-h));
  ye = H(:, size(H)(2));
  a = pinv(xe')'*ye;
  #Y = vector_r(:,1);
  #X = vector_r(:,2:end);
  #X = fliplr(X);
  #a = pinv(X)*Y;
end