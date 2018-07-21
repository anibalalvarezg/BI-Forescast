function [a b] = svmTrain(xe, ye, svm) 
  a = 0;
  b = 0;
  colXe = columns(xe);
  filaXe = rows(xe);
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
  b = (auxMiu * ye) / s;
  a = v - miu*b;
end