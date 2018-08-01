function [r2] = r_function(zv,yv)
  sum = 0;
  sum2 = 0;
  for i=1:length(zv)
    sum = (yv(i)-zv(i))**2;
    sum2 = (yv(i) - mean(yv))**2;
  end
  
  r2 =  1 - (sum/sum2);
endfunction