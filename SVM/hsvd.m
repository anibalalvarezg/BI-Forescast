function [x_L,x_H]= hsvd(tSerie,lag)
 [H, M, L] = vect_reg(lag, tSerie);

  [U,S,V] = svd(H);
  
  U = U';
  S = S';
  V = V';

  C = [];
  for i=1:min(size(S))
    aux = S(i,i)*U(i,:)'*V(i,:);
    C = [C; aux(1,1:L) aux(2:M,L)'];
    if i == 1
      XLaux = aux;
    else
      if i == 2
        XHaux = aux;
      else
        XHaux += aux;
      end
    end
  end
  
  XL = [XLaux(1, :) XLaux(2:size(XLaux)(1), size(XLaux)(2))'];
  XH = [XHaux(1, :) XHaux(2:size(XHaux)(1), size(XHaux)(2))'];

end