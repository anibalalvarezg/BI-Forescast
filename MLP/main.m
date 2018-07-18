% Parameter Setup
Load_data
L = 8;
[x_L,x_H]= hsvd(x_tr,L);

m = 25;
h = 1;

#[Bmlp_H,Bmlp_L] = main_train(x_L,x_H,m,h);
Load(['','Bmlp.mat']);

[y_L, y_H] = hsvd(x_tst,L);
  
zv = mlp_test(xv,Bmlp.W);

 