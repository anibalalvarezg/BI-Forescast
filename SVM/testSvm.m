function [zv]=testSvm(xv,svm)
  xv = xv';
  zv = [];
  for i=1:size(xv)(2)
    value = svm.a'*get_kernelTest(svm.xe, xv(:,i), svm.Sigma2)+svm.b;
    zv = [zv value];
  end
  
end