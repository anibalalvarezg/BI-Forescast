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