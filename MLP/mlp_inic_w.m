function [W]=mlp_inic_w(nInp,mOut,Hlayer)
  H= [nInp Hlayer mOut]; % Hidden nodes by layer
  L = numel(H);
  a=6/sqrt(nInp+mOut);
  for i = 1:L-1
    W{i} = rand(H(i),H(i+1))*2*a-a;
  end
end