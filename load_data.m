# Load data #
data = load('TSerieEjemplo.txt');
dim_data = size(data,1);

min_value = min(data);
max_value = max(data);

# Normalización #
for i=1:dim_data
  data(i) = (data(i)-min_value) / (max_value - min_value);
endfor

# ACF #
n_k = 25;
arr_acf = zeros(1,n_k);
for k=1:n_k
  arr_acf(1,k) = acf(data,k);
endfor

hold on
stem(arr_acf);
  plot([0,25], [0.1,0.1],"b");
  plot([0,25], [-0.1,-0.1],"b");
hold off

# División data en tr y tst #
dim_data_tr = floor(dim_data * 0.8);
x_tr = data(1:dim_data_tr);
y_tr = data(dim_data_tr+1:end); 

