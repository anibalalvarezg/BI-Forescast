  % Parameter Setup
Load_data


HL = 10;
%M = zeros(HL,5);

M = [57   0   0   0   0;
     173   97   111   0   0;
     71   34   0   0   0;
     4   29   0   0   0;
     164   106   159   0   0;
     171   74   0   0   0;
     9   122   66   0   0;
     92   92   12   123   152;
     104   12   0   0   0;
     145   148   131   99   0];

minMseTps = [];
mseTestArr = [];
Bmlp = [];
Bmlp.mse = 1000;
for i = 1:1
  clear mlp;
  printf('\n======== Topologia %d ========', i);
  vector = M(6,1:end);
  vector = vector(vector ~= 0);
  printf("\n Topologia Hlayer:");
  disp(vector);
  printf("\n");
  
  mlp.MaxIter = 5*1e3;
  mlp.mu = 1e-3;
  mlp.Hlayer = [vector];
  for o=1:10
    mlp.W = mlp_inic_w(size(xe,1),size(ye,1),mlp.Hlayer);
    mlp=mlp_train(xe,ye,mlp); % Training MLP
    if Bmlp.mse(length(Bmlp.mse)) > mlp.mse(length(mlp.mse)) 
      Bmlp = mlp;
    end
  end
  zv = mlp_test(xv,Bmlp.W);

  MC = matrix_c(zv,yv);

  VP = MC(1,1);
  FP = MC(1,2);
  FN = MC(2,1);
  VN = MC(2,2);

  P = (VP) / (VP + FP);
  R = (VP) / (VP + FN);
  F = 2 * ((P*R)/(P+R));
  A = (VP + VN) / (VP + FP + VN + FN);
  
  mseTest = mean((yv - zv).^2);
  
  printf('Precision: %f \n',P);
  printf('Exactitud: %f \n',A);
  printf('F-score: %f \n',F);
  printf('Recall: %f \n',R);
  printf('Min mse: %f \n\n', min(mlp.mse));
  printf('mse test: %f', mean((yv - zv).^2));
  minMseTps = [minMseTps min(mlp.mse)];
  mseTestArr = [mseTestArr mseTest];
  
  #figure(1);
  #plot(10*log10(mlp.mse));
  #xlabel('Iterations');
  #ylabel('MSE');
  #grid on;

end

figure(1);
x=[1 2 3 4 5 6 7 8 9 10];
plot(x,mseTestArr);
xlabel('Topologia');
ylabel('MSE');
grid on;

#figure(1);
#plot(10*log10(mlp.mse));
#xlabel('Iterations');
#ylabel('MSE');
#grid on;


#figure(2)
#plot(xv(1,:),yv,'-b',xv(1,:),zv,'r-')
#xlabel('Time')
#ylabel('Sinc Function')
#legend('Actual','Estimated')
#grid on
#fprintf('\n--- Test-MSE: %e',mse(yv,zv));