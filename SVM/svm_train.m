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