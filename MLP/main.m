% Parameter Setup
Load_data
L = 8;
[x_L,x_H]= hsvd(x_tr,L);

m = 25;
h = 1;

vector_r_L = vector_reg(x_L,m,h);
ye_L = vector_r_L(:,1)';
xe_L = fliplr(vector_r_L(:,2:end))';

vector_r_H = vector_reg(x_H,m,h);
ye_H = vector_r_H(:,1)';
xe_H= fliplr(vector_r_H(:,2:end))';

Bmlp_L = mlp(xe_L,ye_L);
#Bmlp_H = mlp(xe_H,ye_H);
