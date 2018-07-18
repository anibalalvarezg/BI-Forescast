function [mse]=mse(y, z)
l_E=y - z;
mse= mean(l_E.^2);
end