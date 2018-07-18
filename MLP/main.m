% Parameter Setup
Load_data
L = 8;
[x_L,x_H]= hsvd(x_tr,L);

m = 25;
h = 1;

[Bmlp_H,Bmlp_L] = main_train(x_L,x_H,m,h);

#Load(['','Bmlp.mat']);

[y_L, y_H] = hsvd(x_tst,L);
  
vector_r_L = vector_reg(y_L,m,h);
y_L = vector_r_L(:,2:end);
y_L = fliplr(y_L);  

vector_r_H= vector_reg(y_H,m,h);
y_H = vector_r_H(:,2:end);
y_H = fliplr(X);  
  
zv =mlp_test(y_L,Bmlp_L.W)+mlp_test(y_H,Bmlp_H.W)

   