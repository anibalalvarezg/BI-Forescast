function [Bmlp] = mlp(xe,ye) 
  HL = 7;
  M = [30  6 1  0 0;
        5   0   0   0   0;
       15   15   0   0   0;
       20  0 0   0   0;
       8   8   0   0   0;
       10 9 0 0 0;
       3 2 0 0 0;]
  minMseTps = [];
  mseTestArr = [];
  Bmlp = [];
  Bmlp.mse = 1000;
  for i = 1:1
    clear mlp;
    printf('\n======== Topologia %d ========', i);
    vector = M(i,1:end);
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
  end
  save(['','Bmlp.mat'],'Bmlp');
#  figure(1);
#  x=[1 2 3 4 5 6 7 8 9 10];
#  plot(x,mseTestArr);
#  xlabel('Topologia');
#  ylabel('MSE');
#  grid on;
endfunction