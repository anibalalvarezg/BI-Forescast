function [auto_cor] = acf(data,k)
  auto_cor = autocov(data,k) / autocov(data,0);
endfunction
