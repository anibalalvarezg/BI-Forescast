# Load data #
data = load('TSerieEjemplo.txt');
dim_data = size(data,1);

min_value = min(data);
max_value = max(data);

for i=1:dim_data
  data(i) = (data(i)-min_value) / (max_value - min_value);
end


dim_data_tr = floor(dim_data * 0.8);
x_tr = data(1:dim_data_tr);
y_tr = data(dim_data_tr+1:end); 

