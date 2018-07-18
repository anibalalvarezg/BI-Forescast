function [Y]= aar_tst(x,m,h,a)
  vector_r = vector_reg(x,m,h);
  X = vector_r(:,2:end);
  X = fliplr(X);
  Y = X*a;
end