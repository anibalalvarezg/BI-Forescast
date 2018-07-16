function [MC] = matrix_c(zv,yv)
  %observaciòn
  b = yv;
  %predicho
  a = zv;
  VP = 0;
  VN = 0;
  FN = 0;
  FP = 0;
  for i=1:columns(a)
    %fprintf('%d  %d\n',a(i),b(i));
    if (a(i) == 1 && b(i) == 1)
      VP++;
    elseif (a(i) == 0 && b(i) == 0)
      VN++;
    elseif(a(i) == 0 && b(i) == 1)
      FN++;
    elseif(a(i) == 1 && b(i) == 0)
      FP++;
    endif

  end 

  P = (VP) / (VP + FP);
  R = (VP) / (VP + FN);
  F = 2 * ((P*R)/(P+R));
  A = (VP + VN) / (VP + FP + VN + FN);

  MC = [VP,FP ; FN,VN];
  
end