function [norm_data] = normalize_data(data)
#  min = 0;
#  max = 1;
  % TSerie = load("./data/SerieTesting.txt");
  max_value = max(data);
  min_value = min(data);
  norm_data = (data - min_value)/(max_value-min_value);
end
