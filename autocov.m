function [auto_cov] = autocov(data,k)
  mean_data = mean(data);
  dim_data  = size(data,1);
  suma = 0;
  
  for t=1:(dim_data-k)
    suma += (data(t) - mean_data) * (data(t+k) - mean_data);
  endfor
  auto_cov = (1/(dim_data-k)) * suma;
endfunction
