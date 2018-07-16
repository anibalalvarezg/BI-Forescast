function [a]=sigmoidAct(x,da)
  if nargin<2
    a = 1./(1 + exp(-x));
  else
    a =x.*(1-x);
  end
end
