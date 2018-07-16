function [z]= mlp_fp(x,W)
  L=length(W)+1;
  z=cell(L);
  z{1}=x;
  for l =1:L-1
    z{l+1}=sigmoidAct(W{l}'*z{l});
  end
end