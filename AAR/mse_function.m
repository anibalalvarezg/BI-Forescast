function [mse] = mse_function(zv,yv)
  mse = 0;
  for i = 1:length(zv)
    mse += (yv(i)-zv(i))**2;
  endfor
  mse /= length(zv);
endfunction