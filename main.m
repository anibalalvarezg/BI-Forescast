# MAIN #
#load_data


x = [1 2 3 4 5 6 7];
L = 3; 
M = 5; 

H = zeros(L,M);
for i=1:L
  for j=1:M
    H(i,j) = x(i+j-1)
  end
end
