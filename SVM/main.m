Load_data

%lag = 30;
memories = [ 15 10 ];
lags = [ 7 2 ];
%training = 80;
horizonte = [1 2];
results = [];
training = false;
testing = true;

%mejMem = memRest(lags(1), memories);

mejorMem = 20;
svm.Gamma = 4;
svm.Sigma2 = 2;

if(training)
  for lag=1:length(lags)
    [x_L x_H] = hsvd(x_tr', lags(lag));
    results{lag}.lag = lags(lag);
      results{lag}.error = [];
      results{lag}.zv = [];

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
if(testing)
  load(['','results.mat']);
  
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
      xe = HL(size(HL)(1):size(HL)(1), :);
      % Se testea
      zvFinal = testSvm(xe, results{lag}.L{h});
      
      % ALTA FRECUENCIA
      [HH, M, L] = vect_reg(mejorMem-1,x_H');
      %[HH, M, L] = MatrizHankel(bestMemory.memory-1,XH);
      xe = HH(size(HH)(1):size(HH)(1), :);
      % Se testea
      zvFinal = zvFinal + testSvm(xe, results{lag}.H{h});
      
      results{lag}.zv = [results{lag}.zv; zvFinal(1,1)];
      
      error = (zvFinal(1,1)-y(h))**2;
      results{lag}.error = [results{lag}.error; error];
    end    
  end
 end