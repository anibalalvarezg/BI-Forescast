function [kernel] = get_kernelTest(x,y,sigma)
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