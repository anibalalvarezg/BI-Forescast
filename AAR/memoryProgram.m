function [bestMemory] = memoryProgram(lag, memories)
  fprintf("TRAINING AR\n");
  results = cell(length(memories));
  
  % Se carga training
  filedtrn = strcat("./data/dtrn");
  load(filedtrn);
  
  % Se carga training
  filedtst = strcat("./data/dtst");
  load(filedtst);
  yv = [dtst(size(dtst)(1), 1)];
  
  % divide training en Alta y Baja frecuencia
  [XL XH] = DescomMultiEscala(dtrn, lag);
  
  bestMemory.memory = 20;
  bestMemory.error =10000;
  
  for lag=1:length(memories)  
    fprintf("MEMORY %d\n", memories(lag));
    % Se predice desde h=1 hasta h=dtst
    zv = [];
    % BAJA FRECUENCIA
    [HL, M, L] = MatrizHankel(memories(lag),XL);
    xe = HL(:, 1:(size(HL)(2)-1));
    ye = HL(:, size(HL)(2));
    % Se entrena
    arL = arTrain(xe, ye);
    
    % ALTA FRECUENCIA
    [HH, M, L] = MatrizHankel(memories(lag),XH);
    xe = HH(:, 1:(size(HH)(2)-1));
    ye = HH(:, size(HH)(2));
    % Se entrena
    arH = arTrain(xe, ye);
      
    % Se predice
    init = size(XL)(1) - memories(lag) + 1;
    endit = size(XL)(1);
    zvL = arL.a'*XL(init:endit,1);
    zvL = zvL';
    zvH = arH.a'*XH(init:endit,1);
    zvH = zvH';
    zv = zvL + zvH;    
    
    % Se obtiene el mse con respecto al horizonte 1
    error = mse(zv,yv);
    
    % Se guarda si tiene un menor error
    if(bestMemory.error > error)
      bestMemory.error = error;
      bestMemory.memory = memories(lag);
    end
    
  end
  
  fprintf("best Memory %d, error %f\n", bestMemory.memory, bestMemory.error);
  
  filemlp = strcat("./data/bestMemory");
  save(filemlp, "bestMemory");
end