function [mnse] = mnse_function(zv,yv)
  suma = 0;
  suma2 = 0;
  
  for i=1:length(zv)
    suma += abs(yv(i) - zv(i));
    suma2+= abs(yv(i) - mean(yv));  
  endfor
  
  mnse = 1 - (suma/suma2);
end