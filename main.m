# MAIN #
load_data
x = x_tr';

#Numero filas
L = 3; 
N = columns(x);

#Numero Columnas
M=N-L+1;
   
H = hankel(x,L);

[U,S,V] = svd(H);
S = diag(S); 

C = zeros(L,N);
for i=1:L
  A =(S(i) * U(1:end,i))* V(1:end,i)';
  C(i,1:end) = [A(1,1:M) A(2:L,M)'];
endfor

m = 120;
y_tr = y_tr';
h = 1;

x_L = C(1,1:end);
for j=2:L 
  x_H = C(j,1:end);
end

y_tst = aar(x_L,m,h) + aar(x_H,m,h);
columns(y_tst)
hold on;
  plot(1:columns(y_tr),y_tr);
  plot(1:columns(y_tst),y_tst,"r");
  legend('Actual Value','Estimated Value');
hold off;
