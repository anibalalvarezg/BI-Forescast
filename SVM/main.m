Load_data

%lag = 30;
memories = [ 10 20 30 40 50 ];
lags = [ 20 30 40 50 ];
%training = 80;
horizonte = [1 40];
results = [];

%mejMem = memRest(lags(1), memories);

mejorMem = 20;

function [H, M, L] = vect_reg(desfase,tSerie)
  N = size(tSerie)(1);
  # L columnas
  L = desfase + 1;
  # M filas
  M = N - L + 1;
  H = [];
  for fila=1:M
    filaH = [];
    for columna=1:L
      filaH = [filaH tSerie(columna+fila-1, 1)];
    end
    H = [H ; filaH];
  end
end


function [svm] = svmTrain(xe, ye, svm) 
  % svm.mse = 100;
  % [Table Param]=svm_grid();
  svm.KerType='RBF';
  % MaxIter=numel(Param); 
  PrevErr=200;   
  
  % Kernel es por cada dato por lo que termina siendo NxN distancia entre todos los datos
  [a b zv]=svm_train(xe',ye',svm);
  svm.a=a; svm.b=b;
  svm.xe = xe';
  svm.zv = zv';
  svm.mse = mse(ye, zv');
  fprintf("Se obtiene a y b para Gamma %d y Sigma2 %d, mse %f \n", svm.Gamma,svm.Sigma2, svm.mse);
    
end

function [kernel] = get_kernel(x,y,sigma)
%kernel RBF
kernel = [];
for i=1:size(x)(2)
  aux = [];
  for j=1:size(y)(2)
    aux = [aux exp(-norm(x(:,i)-y(:,j))**2/(sigma**2))];
  end
  kernel = [kernel; aux];
end

end


function [a b zv]=svm_train(xe,ye,svm)
  H = get_kernel(xe, xe, svm.Sigma2) + eye(size(xe)(2))/svm.Gamma;
  uno=[];
  for i=1:size(xe)(2)
    uno = [uno 1];
  end
  mu = inv(H)*uno';
  v = inv(H)*ye';
  s = uno*mu;
  b = mu'*ye'/s;
  a = v - mu*b;
  
  % testing values
  zv = [];
  for i=1:size(xe)(2)
    value = a'*get_kernel(xe, xe(:,i), svm.Sigma2)+b;
    zv = [zv value];
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

for lag=1:length(lags)
	[x_L x_H] = hsvd(x_tr, lags(lag));
	results{lag}.lag = lags(lag);
    results{lag}.error = [];
    results{lag}.zv = [];

    for h=1:horizonte(1):horizonte(2)
		%fprintf("H=%d\n", h);
    	% BAJA FRECUENCIA
    	[HL, M, L] = vect_reg(mejorMem+h-1,x_L);
    	xe = HL(:, 1:(size(HL)(2)-h));
    	ye = HL(:, size(HL)(2));
      results{lag}.L{h} = svmTrain(xe, ye, svm);
      
      % ALTA FRECUENCIA
      [HH, M, L] = vect_reg(mejorMem+h-1,x_H);
      xe = HH(:, 1:(size(HH)(2)-h));
      ye = HH(:, size(HH)(2));
      % Se entrena
      results{lag}.H{h} = svmTrain(xe, ye, svm);
    end  
end   