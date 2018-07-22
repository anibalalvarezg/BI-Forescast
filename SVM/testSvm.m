function [zv] = svm_tst(xe,xv,svm)
  numFilaXe = rows(xe);
  numFilaXv = rows(xv);
  zv = [];
  for i = 1:numFilaXv
    k2 = [];
    for j = 1: numFilaXe
        suma = xv(i,:) - xe(j,:);
        suma = suma.^2;
        suma = sum(suma);
        suma = sqrt(suma);
        suma = suma.^2;
        suma = exp(-(1/(2*svm.Sigma2))*suma);
        k2(j,1) = suma;
    end
    zv(i) = (svm.a'*k2+svm.b);
  end
  zv = round(zv);
  zv = zv';
end