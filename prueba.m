data = [1 2 3 4 5 6 7 8 9];
h = 1;
lag = 3;

#len = length(data)-lag-h+1;

#for i=1:len
#  xReg(i,:) = data(i:i+lag+h-1)';
#endfor
#xReg
#x = xReg(:,1:lag)
#y = xReg(:,end)

x=data;

N = columns(x);

vector_r = zeros(N,m+1);

for i=1+m:columns(x)
  for j = 1:m+1
    if i >= j
      vector_r(i,j) = x(i-j+1);
    else
      vector_r(i,j) = 0;
    endif
  endfor
endfor
vector_r = vector_r(m+1:end,:);
Y = vector_r(:,1)
X = vector_r(:,2:end)
a = pinv(X)*Y;

a =[1.33333   0.33333  -0.66667];
x =[10 9 8 ];
suma = 0;
for i=1:3
  suma += a(i)*x(i);
endfor
suma