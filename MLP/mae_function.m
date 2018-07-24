function [mae] = mae_function(zv,yv)
  sum = 0;
  
  for i=1:length(zv)
    sum = abs(yv(i)-zv(i));
  end
  
  mae = sum/length(zv);
endfunction