Load_data

%lag = 30;
memories = [ 10 20 30 40 50 ];
lags = [ 20 30 40 50 ];
%training = 80;
horizonte = [1 40];
results = [];

%mejMem = memRest(lags(1), memories);

mejorMem = 20;
svm.Gamma = 4;
svm.Sigma2 = 2;

for lag=1:length(lags)
  [x_L x_H] = hsvd(x_tr', lags(lag));
  results{lag}.lag = lags(lag);
    results{lag}.error = [];
    results{lag}.zv = [];

    for h=1:horizonte(1):horizonte(2)
    %fprintf("H=%d\n", h);
      % BAJA FRECUENCIA
      [HL, M, L] = vect_reg(mejorMem+h-1,x_L');
      xe = HL(:, 1:(size(HL)(2)-h));
      ye = HL(:, size(HL)(2));
      results{lag}.L{h} = svmTrain(xe, ye, svm);
      
      % ALTA FRECUENCIA
      [HH, M, L] = vect_reg(mejorMem+h-1,x_H');
      xe = HH(:, 1:(size(HH)(2)-h));
      ye = HH(:, size(HH)(2));
      % Se entrena
      results{lag}.H{h} = svmTrain(xe, ye, svm);
    end  
end

function [Table Param]=svm_grid()
  a=1;
  b=2;
  stepS = 2;
  stepG = 2;
  sigma = 2**a;
  gamma = 2**a;
  Param = [];
  Gamma = [];
  Sigma2 = [];
  Table = [];
  % sigma son las filas
  while sigma <= 2**b
    aux = [];
    gamma = 2**a;
    % gamma son las columnas
    while gamma <= 2**b
      data.Gamma = gamma;
      data.Sigma2 = sigma;
      aux = [aux data];
      gamma = gamma + stepG;
    end
    Param = [Param aux];
    Table = [Table; aux];
    sigma = sigma + stepS;
  end
end

