data = load('dateset.txt');
dim_data = size(data,1);

# Normalización #
%min_value = min(data);
%max_value = max(data);

%for i=1:dim_data
%  data(i) = (data(i)-min_value) / (max_value - min_value);
%endfor

%[b,a] = butter(5, 1/3);
%data = filtfilt(b,a,data);

%split data for trainning (xe;ye) and test (xv;yv)
dim_data_tr = floor(dim_data * 0.70);
x_tr = data(1:dim_data_tr);
y = data(dim_data_tr+1:end); 

%transpose vectors
x_tr = x_tr';
x_tst = y';

