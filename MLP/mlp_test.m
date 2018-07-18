function [zv] = mlp_test(xv, W)
  L = length(W)+1;
  z = mlp_fp(xv,W);
  zv = z(L,:);
  zv = cell2mat(zv);
  %zv = round(zv);
end