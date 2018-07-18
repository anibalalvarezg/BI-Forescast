function [a]= aar_tr(x,m,h)
  vector_r = vector_reg(x,m,h);
  Y = vector_r(:,1);
  X = vector_r(:,2:end);
  X = fliplr(X);
  a = pinv(X)*Y;
end