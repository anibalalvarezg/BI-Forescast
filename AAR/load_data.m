data = load('dataseth.txt');
dim_data = size(data,1);
data = normalize_data(data);


dim_data_tr = floor(dim_data*0.75);

x_tr = data(1:dim_data_tr)';
x_tst = data(dim_data_tr+1:end)';


