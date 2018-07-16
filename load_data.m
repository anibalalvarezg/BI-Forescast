# Load data #
data = load('TSerieEjemplo.txt');
dim_data = size(data,1);

# ACF #
n_k = 25;
arr_acf = zeros(1,n_k);
for k=1:n_k
  arr_acf(1,k) = acf(data,k);
endfor

# Grafico ACF #
int_H = mean(data) + ((std(data) / sqrt(dim_data))*1.96);

#int_L = mean(data) - ((std(data) / sqrt(dim_data))*1.96);
int_L = mean(data) - ((std(data) / sqrt(dim_data))*1.96);

#hold on
#stem(arr_acf);
#  plot([0,n_k], [0.1,0.1], "r"); #Corregir valor recta, debería ser IC.
#  plot([0,n_k], [-0.1,-0.1], "r")
#hold off


# Normalización #

min_value = min(data);
max_value = max(data);

for i=1:dim_data
  data(i) = (data(i)-min_value) / (max_value - min_value);
endfor

# División data en tr y tst #
dim_data_tr = floor(dim_data * 0.75);
x_tr = data(1:dim_data_tr);
y_tr = data(dim_data_tr+1:end); 

