Load_data

%lag = 30;
memories = [ 40 10 45 ];
lags = [ 6 7 5 ];
%training = 80;
horizonte = [1 1];
results = [];
training = false;
testing = true;

%mejMem = memRest(lags(1), memories);

mejorMem = 10;
%svm.Gamma = 4;
%svm.Sigma2 = 2;

function [Param] = svm_grid();
for i = 1:5
  c(i) = 2.^i
end
for i2 = 1:5
  j = -2:1:2;
  g(i2) = 10.^j(i2)
end
colC = columns(c);
colG = columns(g);
k = 1;
for i=1:colC
  for j=1:colG
    Param(k).Gamma = c(i);
    Param(k).Sigma2 = g(j);
    k++;
  end
end
end

[Param] = svm_grid();
svm.KerType = 'RBF';
MaxIter = numel(Param);
PrevErr = 200;

for i = 1:MaxIter
  svm.Gamma = Param(i).Gamma;
  svm.Sigma2 = Param(i).Sigma2;
  
  if(training)

    for lag=1:length(lags)
      [x_L x_H] = hsvd(x_tr', lags(lag));
      results{lag}.lag = lags(lag);
      %results{lag}.error = [];
      %results{lag}.zv = [];

      for h=1:horizonte(1):horizonte(2)
      %fprintf("H=%d\n", h);
        % BAJA FRECUENCIA
        [HL, M, L] = vect_reg(mejorMem+h-1,x_L');
        xe = HL(:, 1:(size(HL)(2)-h));
        ye = HL(:, size(HL)(2));
        results{lag}.L{h} = svmTrain(xe, ye, svm);
        
        % ALTA FRECUENCIA
        [HH, M, L] = vect_reg(mejorMem+h-1,x_H');
        xe = HH(:, 1:(size(HH)(2)-h));
        ye = HH(:, size(HH)(2));
        % Se entrena
        results{lag}.H{h} = svmTrain(xe, ye, svm);
      end
    end
  end

end
if(testing)
  load(['','results.mat']);
  mse = 9999;
  for lag=1:length(lags)
    
    % divide training en Alta y Baja frecuencia
    [x_L x_H] = hsvd(y', lags(lag));
    
    %fprintf("LAG %d\n", lags(lag));
    results{lag}.error = [];
    % Se predice desde h=1 hasta h=dtst
    results{lag}.zv = [];
    for h=horizonte(1):horizonte(2)
      %fprintf("H=%d\n", h);
      % BAJA FRECUENCIA
      [HL, M, L] = vect_reg(mejorMem-1,x_L');
      %[HL, M, L] = MatrizHankel(bestMemory.memory-1,XL);
      xv = HL(:, 1:(size(HL)(2)));
      % Se testea
      zvFinal = testSvm(xv,results{lag}.L{h});
      
      % ALTA FRECUENCIA
      [HH, M, L] = vect_reg(mejorMem-1,x_H');
      %[HH, M, L] = MatrizHankel(bestMemory.memory-1,XH);
      xv = HH(:, 1:(size(HL)(2)));
      % Se testea
      zvFinal = zvFinal + testSvm(xv,results{lag}.H{h});
      
      results{lag}.zv = [results{lag}.zv; zvFinal(1,1)];
      
      error = (zvFinal(1,1)-y(h))**2;
      mnse = mnse_function(zvFinal,y);
      mae = mae_function(zvFinal,y);
      r = r_function(zvFinal,y);
      results{lag}.error = [results{lag}.error; error];
      if (error < mse)
        mse = error;
        zvBest = zvFinal;
        hBest = h;
        mnseBest = mnse;
        maeBest = mae;
        rBest = r;
      end
    end    
  end
  
end

hold on;
plot(1:length(zvBest),y(mejorMem-1+hBest:end));
plot(1:length(zvBest),zvBest,"r");
%plot(1:columns(results{lag}.zv),results{lag}.zv,"r");
legend('Actual Value','Estimated Value');
hold off;

datatst = y(mejorMem-1+hBest:end);
pronostico = zvBest';
p = polyfit(pronostico,datatst((length(datatst) - length(pronostico))+1:end),1) %% saco los valores y = 32173612873912x + b (los de antes de x y el b)
f = polyval(p,pronostico);

figure(2)
hold on;
plot(pronostico , datatst((length(datatst) - length(pronostico))+1:end),'o');
plot(pronostico,f,'-r');
plot(datatst((length(datatst) - length(pronostico))+1:end),datatst((length(datatst) - length(pronostico))+1:end),':b');
hold off; 
xlabel('X');
ylabel('Y');
%title("AR");
legend("data point", "best linear fit", "Y=X")
set(gca,'XTick',[0:5:100]);
set(gca,'YTick',[0:5:100]);
grid on