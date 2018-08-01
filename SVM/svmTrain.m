function [svm] = svmTrain(xe, ye, svm) 
<<<<<<< HEAD
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
    
=======
  svm.a = 0;
  svm.b = 0;
  svm.xe = 0;
  colXe = columns(xe);
  filaXe = rows(xe);
  svm.xe = xe;
  In = eye(filaXe);
  k = [];
  for i = 1:filaXe
    for j = 1:filaXe
      suma = xe(i,:)-xe(j,:);
      suma = suma.^2;
      suma = sum(suma);
      suma = sqrt(suma);
      suma = suma.^2;
      suma = exp(-(1/(2*svm.Sigma2))*suma);
      k(i,j) = suma;
    end
  end
  
  H = k + (In/svm.Gamma);
  miu = inv(H) * ones(filaXe,1);
  v = inv(H) * ye;
  s = ones(1,filaXe)*miu;
  auxMiu = miu';
  svm.b = (auxMiu * ye) / s;
  svm.a = v - miu*svm.b;
>>>>>>> svm
end