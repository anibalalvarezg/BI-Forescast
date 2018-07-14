# MAIN #
load_data

x = x_tr';

#Numero filas
L = 20; 
N = columns(x);
M=N-L+1;

H = hankel(x,L);

[U,S,V] = svd(H);
S = diag(S);