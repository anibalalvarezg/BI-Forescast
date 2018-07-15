# MAIN #
load_data

x = x_tr';

#Numero filas
L = 8; 
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

m = 200;
h = 1;

x_L = C(1,1:end);
x_H = C(2,1:end) + C(3,1:end);

aar(x_L,m,h) + aar(x_H,m,h)
y_tr(1)
