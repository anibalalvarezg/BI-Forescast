<<<<<<< HEAD
function [zv]=testSvm(xv,svm)
  xv = xv';
  zv = [];
  for i=1:size(xv)(2)
    value = svm.a'*get_kernelTest(svm.xe, xv(:,i), svm.Sigma2)+svm.b;
    zv = [zv value];
  end
  
=======
function [zv] = testSvm(xv,svm)
  numFilaXe = rows(svm.xe);
  numFilaXv = rows(xv);
  zv = [];
  for i = 1:numFilaXv
    k2 = [];
    for j = 1: numFilaXe
        suma = xv(i,:) - svm.xe(j,:);
        %suma = xe(:,i) - xv(:,j);
        suma = suma.^2;
        suma = sum(suma);
        suma = sqrt(suma);
        suma = suma.^2;
        suma = exp(-(1/(2*svm.Sigma2))*suma);
        k2(j,1) = suma;
    end
    zv(i) = (svm.a'*k2+svm.b);
  end
  %zv = round(zv);
  zv = zv';
>>>>>>> svm
end