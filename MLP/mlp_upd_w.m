function [W mse]=mlp_upd_w(y,z,W,mu)
  L=length(W)+1;
  l_E=cell(1,L-1);
  l_E{L-1}=y - z{L};
  mse= mean(l_E{L-1}.^2);
  for k = (L-1):-1:2
    l_delta{k} = l_E{k}.*sigmoidAct(z{k+1},1);
    l_E{k-1} = W{k}*l_delta{k} ;
  end
  l_delta{1}=l_E{1}.*sigmoidAct(z{2},1);
  for k = 1:L-1
    W{k} =W{k}+mu* z{k}*(l_delta{k})';
  end
end