function [norm_data] = normalize_data(data)
  minimum = 0;
  maximum = 1;
  % TSerie = load("./data/SerieTesting.txt");
  max_value = max(data);
  min_value = min(data);
  norm_data = (maximum-minimum) * (data - min_value)/(max_value-min_value)+minimum;
end
